"use client";

import { authorization } from "@/api/authorization";
import { createMessage } from "@/api/messages/api";
import { updateRoom as innerUpdateRoom } from "@/api/rooms/api";
import { RadioButtonOptions } from "@/component/RadioButtonGroup";
import { useParams } from "next/navigation";
import {
  createContext,
  PropsWithChildren,
  useCallback,
  useContext,
  useState,
} from "react";

type SelectedStore = {
  value: number;
  label: string;
};

type ReportContextType = ReturnType<typeof useReport>;

export const ReportContext = createContext<ReportContextType>(
  {} as ReportContextType
);

const useReport = ({
  store1,
  store2,
  roomName,
}: {
  store1?: Store;
  store2?: Store;
  roomName: string | null;
}) => {
  const params = useParams();
  const roomId = params.id as string;

  const [clientMessages, setClientMessages] = useState<string | undefined>(
    undefined
  );
  const [newMessage, setNewMessage] = useState<string | undefined>(undefined);
  const [selectedIndex, setSelectedIndex] = useState<number | undefined>(
    undefined
  );
  const [selectedStore, setSelectedStore] = useState<{
    [key: number]: SelectedStore | undefined;
  }>({
    // 店舗情報がある場合は初期値を設定
    0: store1 ? { value: store1.id, label: store1.name } : undefined,
    1: store2 ? { value: store2.id, label: store2.name } : undefined,
  });

  const getSseMessage = useCallback(async () => {
    setClientMessages(undefined);

    const authInfo = await authorization();
    const res = await fetch(
      `${process.env.NEXT_PUBLIC_SERVER_HOST}/rooms/${roomId}/messages/sse`,
      {
        headers: {
          Authorization:
            "Basic " +
            btoa(`${authInfo.basicAuthUser}:${authInfo.basicAuthPassword}`),
        },
      }
    );
    const reader = res.body?.getReader()!;
    const decoder = new TextDecoder();

    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      if (!value) continue;

      const lines = decoder.decode(value);
      const message = lines
        .split("\n\n") // イベントごとに分割
        .map((block) => {
          const dataLine = block
            .split("\n")
            .find((line) => line.startsWith("data:"));
          if (!dataLine) return null; // data がない場合はスキップ
          try {
            const json = JSON.parse(dataLine.replace("data: ", ""));
            return json.message; // message を取得
          } catch {
            return null; // JSON パースエラー時はスキップ
          }
        })
        .filter((message): message is string => message !== null)
        .join("");

      setClientMessages((prevText) =>
        prevText ? prevText + message : message
      );
    }
  }, [roomId]);

  const sendMessage = useCallback(async () => {
    if (!selectedStore[0] || !selectedStore[1] || !newMessage) {
      return;
    }

    await createMessage({
      message: newMessage,
      roomId,
    });

    setNewMessage("");

    await getSseMessage();
  }, [getSseMessage, newMessage, roomId, selectedStore]);

  const setStore = useCallback(
    (value: string, options: RadioButtonOptions) => {
      if (selectedIndex === undefined) {
        return;
      }

      const selectedOption = options.find((e) => e.value === Number(value));
      setSelectedStore((prev) => {
        return { ...prev, [selectedIndex]: selectedOption };
      });
    },
    [selectedIndex]
  );

  const setMessage = useCallback(
    (e: React.ChangeEvent<HTMLTextAreaElement>) => {
      setNewMessage(e.target.value);
    },
    []
  );

  const updateRoom = useCallback(async () => {
    await innerUpdateRoom({
      roomId,
      name: roomName,
      store1Id: selectedStore[0]?.value ?? null,
      store2Id: selectedStore[1]?.value ?? null,
    });
  }, [roomId, roomName, selectedStore]);

  return {
    selectedStore,
    selectedIndex,
    setSelectedIndex,
    setStore,
    newMessage,
    setMessage,
    sendMessage,
    updateRoom,
    clientMessages,
  };
};

type Store = {
  id: number;
  name: string;
};

type Props = {
  store1?: Store;
  store2?: Store;
  roomName: string | null;
};

export const ReportContextProvider = ({
  children,
  roomName,
  store1,
  store2,
}: PropsWithChildren<Props>) => {
  const value = useReport({ store1, store2, roomName });
  return (
    <ReportContext.Provider value={value}>{children}</ReportContext.Provider>
  );
};

export const useReportContext = () => useContext(ReportContext);

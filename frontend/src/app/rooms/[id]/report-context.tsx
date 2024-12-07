"use client";

import { updateRoom as innerUpdateRoom } from "@/api/message/api";
import { createMessage } from "@/api/report/api";
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

  const [sseMessage, setSseMessage] = useState<string | undefined>(undefined);
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
  const [newMessage, setNewMessage] = useState("");

  const getSseMessage = useCallback(async () => {
    setSseMessage(undefined);

    const res = await fetch(
      `${process.env.NEXT_PUBLIC_SERVER_HOST}/rooms/${roomId}/messages/sse`,
      {
        headers: {
          Authorization:
            "Basic " +
            btoa(
              `${process.env.BASIC_AUTH_USER}:${process.env.BASIC_AUTH_PASSWORD}`
            ),
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
      const messages = lines
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

      setSseMessage((prevText) => (prevText ? prevText + messages : messages));
    }
  }, [roomId]);

  const sendMessage = useCallback(async () => {
    if (!selectedStore[0] || !selectedStore[1]) {
      return;
    }

    setNewMessage("");

    await createMessage({
      message: newMessage,
      roomId,
    });

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
    sseMessage,
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

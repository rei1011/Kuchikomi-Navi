"use client";

import { getComparisonReport } from "@/api/report/api";
import { updateRoom as innerUpdateRoom } from "@/api/report/rooms/api";
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
  const [compareMethod, setCompareMethod] = useState("");
  const [report, setReport] = useState("");

  const getReport = useCallback(async () => {
    if (!selectedStore[0] || !selectedStore[1]) {
      return;
    }

    setCompareMethod("");

    const res = await getComparisonReport({
      stores: [selectedStore[0].value, selectedStore[1].value],
      compareMethod,
    });

    setReport(res.report);
  }, [compareMethod, selectedStore]);

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

  const setMethod = useCallback((e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setCompareMethod(e.target.value);
  }, []);

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
    compareMethod,
    setMethod,
    getReport,
    report,
    updateRoom,
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

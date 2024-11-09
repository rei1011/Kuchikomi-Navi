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

const useReport = () => {
  const params = useParams();
  const roomId = params.id as string;

  const [selectedIndex, setSelectedIndex] = useState<number | undefined>(
    undefined
  );
  const [selectedStore, setSelectedStore] = useState<{
    [key: number]: SelectedStore | undefined;
  }>({
    0: undefined,
    1: undefined,
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
    await innerUpdateRoom(
      roomId,
      selectedStore[0]?.value ?? null,
      selectedStore[1]?.value ?? null
    );
  }, [roomId, selectedStore]);

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

export const ReportContextProvider = ({ children }: PropsWithChildren) => {
  const value = useReport();
  return (
    <ReportContext.Provider value={value}>{children}</ReportContext.Provider>
  );
};

export const useReportContext = () => useContext(ReportContext);

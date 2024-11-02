"use client";

import { getComparisonReport } from "@/api/report/api";
import {
  createContext,
  PropsWithChildren,
  useCallback,
  useContext,
  useState,
} from "react";

type ReportContextType = ReturnType<typeof useReport>;

export const ReportContext = createContext<ReportContextType>(
  {} as ReportContextType
);

const useReport = () => {
  const [selectedIndex, setSelectedIndex] = useState<number | undefined>(
    undefined
  );
  const [selectedStore, setSelectedStore] = useState({
    0: undefined,
    1: undefined,
  });
  const [compareMethod, setCompareMethod] = useState("");
  const [report, setReport] = useState("");

  const getReport = useCallback(async () => {
    if (!selectedStore[0] || !selectedStore[1]) {
      return;
    }

    const res = await getComparisonReport({
      stores: [selectedStore[0], selectedStore[1]],
      compareMethod,
    });

    setReport(res.report);
  }, [compareMethod, selectedStore]);

  const setStore = useCallback(
    (value: string) => {
      if (selectedIndex === undefined) {
        return;
      }

      setSelectedStore((prev) => {
        return { ...prev, [selectedIndex]: value };
      });
    },
    [selectedIndex]
  );

  return {
    selectedStore,
    selectedIndex,
    setSelectedIndex,
    setStore,
    compareMethod,
    setCompareMethod,
    getReport,
    report,
  };
};

export const ReportContextProvider = ({ children }: PropsWithChildren) => {
  const value = useReport();
  return (
    <ReportContext.Provider value={value}>{children}</ReportContext.Provider>
  );
};

export const useReportContext = () => useContext(ReportContext);

"use client";

import { useReportContext } from "@/app/report-context";
import { StickyInput } from "@/component/StickyInput";

export const SendMessageSection = () => {
  const { getReport, setMethod, compareMethod, selectedStore } =
    useReportContext();
  return (
    <div className="w-full">
      <StickyInput
        onSubmit={getReport}
        onChange={setMethod}
        value={compareMethod}
        disabled={selectedStore[0] == null || selectedStore[1] == null}
      />
    </div>
  );
};

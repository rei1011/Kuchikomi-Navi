"use client";

import { useReportContext } from "@/app/report-context";
import { StickyInput } from "@/component/StickyInput";

export const SendMessageSection = () => {
  const { getReport, setMethod, compareMethod } = useReportContext();
  return (
    <div className="w-full">
      <StickyInput
        onSubmit={getReport}
        onChange={setMethod}
        value={compareMethod}
      />
    </div>
  );
};

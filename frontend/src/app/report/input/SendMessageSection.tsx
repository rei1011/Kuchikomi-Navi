"use client";

import { useReportContext } from "@/app/report-context";
import { StickyInput } from "@/component/StickyInput";

export const SendMessageSection = () => {
  const { getReport, setMethod } = useReportContext();
  return (
    <div>
      <StickyInput onSubmit={getReport} onChange={setMethod} />
    </div>
  );
};

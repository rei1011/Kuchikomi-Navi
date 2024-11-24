"use client";

import { StickyInput } from "@/component/StickyInput";
import { useReportContext } from "../report-context";

export const SendMessageSection = () => {
  const { getReport, setMethod, newMessage, selectedStore } =
    useReportContext();
  return (
    <div className="w-full">
      <StickyInput
        onSubmit={getReport}
        onChange={setMethod}
        value={newMessage}
        disabled={selectedStore[0] == null || selectedStore[1] == null}
      />
    </div>
  );
};

"use client";

import { StickyInput } from "@/component/StickyInput";
import { useReportContext } from "../report-context";

export const SendMessageSection = () => {
  const { sendMessage, setMessage, newMessage, selectedStore } =
    useReportContext();
  return (
    <div className="w-full">
      <StickyInput
        onSubmit={sendMessage}
        onChange={setMessage}
        value={newMessage}
        disabled={selectedStore[0] == null || selectedStore[1] == null}
      />
    </div>
  );
};

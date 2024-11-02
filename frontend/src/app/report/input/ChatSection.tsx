"use client";

import { StickyInput } from "@/component/StickyInput";

export const ChatSection = () => {
  console.log("ChatSection");
  return (
    <div>
      <StickyInput
        onSubmit={() => console.log("submit")}
        onChange={(e) => console.log(e.target.value)}
      />
    </div>
  );
};

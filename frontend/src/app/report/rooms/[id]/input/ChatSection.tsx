"use client";

import { useReportContext } from "@/app/report/rooms/[id]/report-context";
import { ChatMessage } from "@/component/ChatMessage";

export const ChatSection = () => {
  const { allMessages } = useReportContext();
  return (
    <div className="w-full">
      <div className="flex flex-col gap-4">
        {allMessages.map((message) => (
          <ChatMessage
            key={message.id}
            $role={message.role}
            message={message.value}
          />
        ))}
      </div>
    </div>
  );
};

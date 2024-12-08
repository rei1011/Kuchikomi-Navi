"use client";

import { Messages } from "@/api/messages/type";
import { ChatMessage } from "@/component/ChatMessage";
import { useEffect, useRef } from "react";
import { useReportContext } from "../report-context";

type Props = {
  messages: Messages;
};

export const ChatMessages = (props: Props) => {
  const { messages } = props;
  const { clientMessages } = useReportContext();
  const messagesEndRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({
      behavior: "smooth",
      block: "end",
    });
  }, [clientMessages]);

  return (
    <div className="w-full">
      <div className="flex flex-col gap-4">
        {messages.map((message) => (
          <ChatMessage
            key={message.id}
            $role={message.role}
            message={message.value}
          />
        ))}
        {clientMessages.map((message, index) => (
          <ChatMessage
            key={`client_message_${index}`}
            $role={message.role}
            message={message.value}
          />
        ))}
        <div ref={messagesEndRef} />
      </div>
    </div>
  );
};

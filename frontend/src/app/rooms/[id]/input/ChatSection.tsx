import { findMessages } from "@/api/report/api";
import { ChatMessage } from "@/component/ChatMessage";

type Props = {
  roomId: string;
};

export const ChatSection = async (props: Props) => {
  const { roomId } = props;
  const allMessages = await findMessages(roomId);
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

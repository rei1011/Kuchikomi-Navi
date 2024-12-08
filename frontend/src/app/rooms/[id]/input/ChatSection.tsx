import { findMessages } from "@/api/messages/api";
import { ChatMessages } from "./ChatMessages";

type Props = {
  roomId: string;
};

export const ChatSection = async (props: Props) => {
  const { roomId } = props;
  const messages = await findMessages(roomId);
  return <ChatMessages messages={messages} />;
};

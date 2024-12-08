import { findRoomById } from "@/api/rooms/api";
import { MessageContextProvider } from "./message-context";

export default async function MessageLayout({
  params,
  children,
}: {
  params: Promise<{ id: string }>;
  children: React.ReactNode;
}) {
  const id = (await params).id;
  const room = await findRoomById(id);
  return (
    <MessageContextProvider
      roomName={room.name}
      store1={room.store1}
      store2={room.store2}
    >
      {children}
    </MessageContextProvider>
  );
}

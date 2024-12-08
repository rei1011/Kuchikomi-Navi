import { findAllRooms } from "@/api/rooms/api";
import { RoomList } from "./RoomList";

export const RoomListWrapper = async () => {
  const rooms = await findAllRooms();
  if (!rooms) {
    // TODO: EmptyViewの作成
    return <>Empty View</>;
  }
  return <RoomList rooms={rooms.list} />;
};

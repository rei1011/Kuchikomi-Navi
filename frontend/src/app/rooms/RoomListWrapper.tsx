import { findAllRooms } from "@/api/message/api";
import { RoomList } from "./RoomList";

export const RoomListWrapper = async () => {
  const rooms = await findAllRooms();
  if (!rooms) {
    // TODO: EmptyViewの作成
    return <>Empty View</>;
  }
  return <RoomList rooms={rooms.list} />;
};

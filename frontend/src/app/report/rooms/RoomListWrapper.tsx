import { getRooms } from "@/api/report/rooms/api";
import { RoomList } from "./RoomList";

export const RoomListWrapper = async () => {
  const rooms = await getRooms();
  if (!rooms) {
    // TODO: EmptyViewの作成
    return <>Empty View</>;
  }
  return <RoomList rooms={rooms.list} />;
};

"use client";

import { Rooms } from "@/api/report/rooms/type";
import { ClickableList } from "@/component/ClickableList";

type Props = {
  rooms: Rooms;
};

export const RoomList = (props: Props) => {
  const { rooms } = props;
  return <ClickableList items={rooms} />;
};

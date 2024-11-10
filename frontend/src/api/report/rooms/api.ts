"use server";

import { client } from "@/api/client";
import { paths } from "../../../../openapi/schema";

export async function findAllRooms() {
  const path = "/rooms";
  const apiClient = client<paths>();
  const res = await apiClient.GET(path);

  if (res.error) {
    throw new Error(`Failed to fetch data. path = ${path}`);
  }

  return res.data;
}

export async function createRoom(id: number) {
  const path = "/rooms";
  const apiClient = client<paths>();
  const res = await apiClient.POST(path, {
    body: {
      user_id: id,
    },
  });

  if (res.error) {
    throw new Error(`Failed create room. path = ${path}`);
  }

  return res.data;
}

export async function updateRoom(
  roomId: string,
  store1Id: number | null,
  store2Id: number | null
) {
  const path = `/rooms/{room_id}`;
  const apiClient = client<paths>();
  const res = await apiClient.PATCH(path, {
    params: {
      path: { room_id: roomId },
    },
    body: {
      store1_id: store1Id,
      store2_id: store2Id,
    },
  });
}

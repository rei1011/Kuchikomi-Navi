"use server";

import { client } from "@/api/client";
import { revalidatePath } from "next/cache";
import { paths } from "../../../openapi/schema";

export async function findAllRooms() {
  const path = "/rooms";
  const apiClient = client<paths>();
  const res = await apiClient.GET(path);

  if (res.error) {
    throw new Error(
      // @ts-ignore
      `Failed to fetch findAllRooms. path = ${path} error = ${res.error.toString()}`
    );
  }

  return res.data;
}

export async function findRoomById(id: string) {
  const path = `/rooms/{room_id}`;
  const apiClient = client<paths>();
  const res = await apiClient.GET(path, {
    params: {
      path: {
        room_id: id,
      },
    },
  });

  if (res.error) {
    throw new Error(
      // @ts-ignore
      `Failed to fetch findRoomById. path = ${path} error = ${res.error.toString()}`
    );
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
    throw new Error(
      // @ts-ignore
      `Failed create room. path = ${path} error=${res.error.toString()}`
    );
  }

  revalidatePath("/rooms");

  return res.data;
}

export async function updateRoom({
  roomId,
  name,
  store1Id,
  store2Id,
}: {
  roomId: string;
  name: string | null;
  store1Id: number | null;
  store2Id: number | null;
}) {
  const path = `/rooms/{room_id}`;
  const apiClient = client<paths>();
  await apiClient.PATCH(path, {
    params: {
      path: { room_id: roomId },
    },
    body: {
      name,
      store1_id: store1Id,
      store2_id: store2Id,
    },
  });

  revalidatePath("/rooms/[id]", "layout");
  revalidatePath("/rooms", "layout");
}

export async function deleteRoom(roomId: string) {
  const path = `/rooms/{room_id}`;
  const apiClient = client<paths>();
  await apiClient.DELETE(path, {
    params: {
      path: {
        room_id: roomId,
      },
    },
  });

  revalidatePath("/rooms");
}

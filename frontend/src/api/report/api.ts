"use server";

import { revalidatePath } from "next/cache";
import { paths } from "../../../openapi/schema";
import { client } from "../client";

export async function createMessage({
  stores,
  message,
  roomId,
}: {
  stores: number[];
  message: string;
  roomId: string;
}) {
  const path = "/rooms/{room_id}/messages";
  const apiClient = client<paths>();
  const res = await apiClient.POST(path, {
    params: {
      path: {
        room_id: roomId,
      },
    },
    body: {
      stores,
      message,
    },
  });

  if (res.error) {
    throw new Error(`Failed to createMessage. path = ${path}`);
  }

  revalidatePath("/report/rooms/[id]", "layout");
}

export async function findMessages(roomId: string) {
  const path = "/rooms/{room_id}/messages";
  const apiClient = client<paths>();
  const res = await apiClient.GET(path, {
    params: {
      path: {
        room_id: roomId,
      },
    },
  });

  if (res.error) {
    throw new Error(`Failed to findMessages. path = ${path}`);
  }

  return res.data;
}

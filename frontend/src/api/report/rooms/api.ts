"use server";

import { client } from "@/api/client";
import { paths } from "../../../../openapi/schema";

export async function getRooms() {
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

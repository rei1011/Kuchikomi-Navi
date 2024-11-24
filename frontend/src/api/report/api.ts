"use server";

import { paths } from "../../../openapi/schema";
import { client } from "../client";

export async function getComparisonReport({
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
  const res = await apiClient.GET(path, {
    params: {
      query: { stores, message },
      path: {
        room_id: roomId,
      },
    },
  });

  if (res.error) {
    throw new Error(`Failed to fetch data. path = ${path}`);
  }

  return res.data;
}

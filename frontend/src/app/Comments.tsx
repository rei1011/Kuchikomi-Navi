"use client";

import createClient from "openapi-fetch";
import useSWR from "swr";
import { paths } from "../../openapi/schema";

export function Comments() {
  const { data: res } = useSWR("/comments", () => {
    return createClient<paths>({
      baseUrl: process.env.NEXT_PUBLIC_SERVER_HOST,
    }).GET("/comments");
  });

  if (!res) return <div>Loading...</div>;

  return <ul>{JSON.stringify(res.data)}</ul>;
}

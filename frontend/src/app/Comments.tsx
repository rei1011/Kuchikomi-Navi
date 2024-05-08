"use client";

import { useRouter } from "next/navigation";
import createClient from "openapi-fetch";
import useSWR from "swr";
import { paths } from "../../openapi/schema";

export function Comments() {
  const router = useRouter();
  const { data: res } = useSWR("/comments", () => {
    return createClient<paths>({
      baseUrl: process.env.NEXT_PUBLIC_SERVER_HOST,
    }).GET("/comments");
  });

  if (!res)
    return (
      <div>
        <button onClick={() => router.push("/sample")}>
          Sample Pageへ遷移
        </button>
        <div>Loading....</div>
      </div>
    );

  return (
    <div>
      <button onClick={() => router.push("/sample")}> Sample Pageへ遷移</button>
      <ul>{JSON.stringify(res.data)}</ul>
    </div>
  );
}

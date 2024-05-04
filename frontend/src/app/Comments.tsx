"use client";

import createClient from "openapi-fetch";
import { useEffect, useState } from "react";
import { paths } from "../../openapi/schema";

export function Comments() {
  const client = createClient<paths>({
    baseUrl: process.env.NEXT_PUBLIC_SERVER_HOST,
  });

  const [data, setData] = useState<any[] | undefined>(undefined);

  useEffect(() => {
    client.GET("/comments").then((response) => {
      setData(response.data);
    });
  }, []);

  if (!data) return <div>Loading...</div>;

  return <ul>{JSON.stringify(data)}</ul>;
}

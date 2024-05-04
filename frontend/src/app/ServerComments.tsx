import createClient from "openapi-fetch";
import { paths } from "../../openapi/schema";

async function getData() {
  const client = createClient<paths>({
    baseUrl: process.env.NEXT_PUBLIC_SERVER_HOST,
  });
  const res = await client.GET("/comments");

  return res.data;
}

export async function ServerComments() {
  const data = await getData();

  return <main>{JSON.stringify(data)}</main>;
}

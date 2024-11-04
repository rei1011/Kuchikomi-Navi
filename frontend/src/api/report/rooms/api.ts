import { client } from "@/api/client";
import { paths } from "../../../../openapi/schema";

const path = "/rooms";

export async function getRooms() {
  const apiClient = client<paths>();
  const res = await apiClient.GET(path);

  if (res.error) {
    throw new Error(`Failed to fetch data. path = ${path}`);
  }

  return res.data;
}

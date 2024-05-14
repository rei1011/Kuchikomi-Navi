import { paths } from "../../../openapi/schema";
import { client } from "../client";

export async function getStore() {
  const apiClient = client<paths>();
  const res = await apiClient.GET("/stores");

  if (res.error) {
    throw new Error(`Failed to fetch data. path = /stores`);
  }

  return res.data;
}

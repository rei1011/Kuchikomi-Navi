"use server";
import { paths } from "../../../openapi/schema";
import { client } from "../client";

const path = "/stores";

export async function getStore(keyword?: string) {
  const apiClient = client<paths>();
  const res = await apiClient.GET(path, {
    params: { query: { keyword } },
  });

  if (res.error) {
    throw new Error(`Failed to fetch data. path = /stores`);
  }

  return res.data;
}

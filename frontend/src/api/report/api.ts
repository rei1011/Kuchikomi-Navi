"use server";

import { paths } from "../../../openapi/schema";
import { client } from "../client";

const path = "/comparison_report";

export async function getComparisonReport({
  stores,
  compareMethod,
}: {
  stores: string[];
  compareMethod: string;
}) {
  const apiClient = client<paths>();
  const res = await apiClient.GET(path, {
    params: {
      query: { stores, compare_method: compareMethod },
    },
  });

  if (res.error) {
    throw new Error(`Failed to fetch data. path = ${path}`);
  }

  return res.data;
}

"use client";

import { useReportContext } from "@/app/report-context";

export const ChatSection = () => {
  const { report } = useReportContext();
  return <div className="w-4/5">{report}</div>;
};

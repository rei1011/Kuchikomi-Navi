"use client";

import { useReportContext } from "@/app/report-context";

export const ReportResult = () => {
  const { report } = useReportContext();
  return (
    <div>
      <h1>Report</h1>
      <p>{report}</p>
    </div>
  );
};

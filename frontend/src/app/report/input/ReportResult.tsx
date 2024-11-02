"use client";

import { useReportContext } from "@/app/report-context";

export const ReportResult = () => {
  const { report } = useReportContext();
  return (
    <div>
      <p>{report}</p>
    </div>
  );
};

"use client";
import { useReportContext } from "@/app/report-context";
import { Button } from "@mui/material";

export const ExecuteButton = () => {
  const { getReport } = useReportContext();
  return (
    <div className="flex justify-center">
      <Button variant="contained" onClick={getReport} className="w-full">
        比較する
      </Button>
    </div>
  );
};

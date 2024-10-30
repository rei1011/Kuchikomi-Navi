"use client";
import { useReportContext } from "@/app/report-context";
import { TextareaAutosize } from "@mui/material";
import { useMemo } from "react";

export const InputHowToCompareArea = () => {
  const { setCompareMethod } = useReportContext();
  return useMemo(
    () => (
      <div className="w-full">
        <TextareaAutosize
          minRows={4}
          className="w-full p-4"
          onChange={(e) => {
            setCompareMethod(e.target.value);
          }}
        />
      </div>
    ),
    [setCompareMethod]
  );
};

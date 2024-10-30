"use client";
import { getComparisonReport } from "@/api/report/api";
import { Button } from "@mui/material";

export const ExecuteButton = () => {
  return (
    <div className="flex justify-center">
      <Button
        variant="contained"
        onClick={async () => {
          const res = await getComparisonReport({
            stores: ["test"],
            compareMethod: "test",
          });

          console.log(res);
        }}
      >
        比較する
      </Button>
    </div>
  );
};

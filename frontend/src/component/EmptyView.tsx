import { SlaveryWhipSvgrepoCom } from "@/components/icons";
import { Typography } from "@mui/material";

export function EmptyView() {
  return (
    <div className="flex flex-col items-center">
      <Typography variant="h4" className="text-gray">
        Not Found !!
      </Typography>
      <SlaveryWhipSvgrepoCom style={{ width: "256px", height: "256px" }} />
    </div>
  );
}

import { Whip } from "@/components/icons";
import { Typography } from "@mui/material";

export function EmptyView() {
  return (
    <div className="flex flex-col items-center gap-y-8">
      <Typography variant="h6" className="text-gray">
        Not found ...
      </Typography>
      <Whip style={{ width: "120px" }} />
    </div>
  );
}

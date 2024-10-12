import MenuIcon from "@mui/icons-material/Menu";
import SummarizeIcon from "@mui/icons-material/Summarize";
import { Box, MenuItem, Menu as MuiMenu } from "@mui/material";
import Link from "next/link";
import { useState } from "react";

export const Menu = () => {
  const [anchorEl, setAnchorEl] = useState<null | SVGSVGElement>(null);
  const open = Boolean(anchorEl);
  const handleClick = (event: React.MouseEvent<SVGSVGElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <>
      <MenuIcon onClick={handleClick} />
      <MuiMenu
        id="basic-menu"
        anchorEl={anchorEl}
        open={open}
        onClose={handleClose}
      >
        <Link href="/report/input">
          <Box
            sx={{
              display: "flex",
              alignItems: "center",
              p: 1,
            }}
          >
            <SummarizeIcon />
            <MenuItem>AI Report</MenuItem>
          </Box>
        </Link>
      </MuiMenu>
    </>
  );
};

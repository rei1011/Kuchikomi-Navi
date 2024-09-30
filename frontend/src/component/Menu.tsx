import MenuIcon from "@mui/icons-material/Menu";
import { MenuItem, Menu as MuiMenu } from "@mui/material";
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
        <MenuItem>AI Report</MenuItem>
      </MuiMenu>
    </>
  );
};

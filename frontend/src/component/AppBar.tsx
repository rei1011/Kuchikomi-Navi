import { Box, AppBar as MuiAppBar, Toolbar, Typography } from "@mui/material";
import { PropsWithChildren } from "react";

type AppBarProps = {
  className?: string;
};

/**
 * AppBar
 * @returns
 */
export function AppBar(props: PropsWithChildren<AppBarProps>) {
  const { className } = props;
  return (
    <Box sx={{ width: 1 }} className={`bg-primary ${className}`}>
      <MuiAppBar position="static" color="transparent" elevation={0}>
        <Toolbar>
          <Box
            sx={{
              width: 1,
              display: "flex",
              alignItems: "center",
              justifyContent: "space-between",
            }}
          >
            <Typography
              variant="h5"
              component="span"
              sx={{ fontWeight: "bold" }}
              className="text-black font-bold"
            >
              M.
            </Typography>
            {props.children}
          </Box>
        </Toolbar>
      </MuiAppBar>
    </Box>
  );
}

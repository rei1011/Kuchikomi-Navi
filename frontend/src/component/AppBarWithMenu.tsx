"use client";

import { AppBar as CAppBar } from "@/component/AppBar";
import { Menu } from "@/component/Menu";

export const AppBarWithMenu = () => {
  return (
    <CAppBar>
      <Menu />
    </CAppBar>
  );
};

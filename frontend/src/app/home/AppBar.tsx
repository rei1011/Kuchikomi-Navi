"use client";

import { AppBar as CAppBar } from "@/component/AppBar";
import { SearchField } from "@/component/SearchField";

export function AppBar() {
  return (
    <CAppBar>
      <SearchField submit={console.dir} className="w-full pl-4" />
    </CAppBar>
  );
}

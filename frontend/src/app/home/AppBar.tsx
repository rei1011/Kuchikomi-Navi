"use client";

import { AppBar as CAppBar } from "@/component/AppBar";
import { Menu } from "@/component/Menu";
import { SearchField } from "@/component/SearchField";
import { isBlank } from "@/utils/string-utils";
import SearchIcon from "@mui/icons-material/Search";
import { Box, Stack } from "@mui/material";
import { useRouter, useSearchParams } from "next/navigation";
import { useSearchField } from "./hooks/useSearchField";

const queryParamKey = "keyword";

export function AppBar() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const keyword = searchParams.get(queryParamKey);
  const { searchFieldOpen, toggleSearchField } = useSearchField();

  return (
    <Box sx={{ width: 1 }} className={`bg-primary`}>
      <Stack>
        <CAppBar>
          <Stack direction="row" spacing={2}>
            <SearchIcon onClick={toggleSearchField} />
            <Menu />
          </Stack>
        </CAppBar>
        <SearchField
          defaultValue={keyword}
          isOpen={searchFieldOpen}
          placeholder="渋谷"
          submit={(keyword: string | null) => {
            if (isBlank(keyword)) {
              router.push("/");
            }
            router.push(`?${queryParamKey}=${keyword}`);
          }}
          className="w-full px-4"
        />
      </Stack>
    </Box>
  );
}

"use client";

import { AppBar as CAppBar } from "@/component/AppBar";
import { SearchField } from "@/component/SearchField";
import { isBlank } from "@/utils/string-utils";
import { useRouter, useSearchParams } from "next/navigation";

const queryParamKey = "keyword";

export function AppBar() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const keyword = searchParams.get(queryParamKey);

  return (
    <CAppBar>
      <SearchField
        defaultValue={keyword}
        submit={(keyword: string | null) => {
          if (isBlank(keyword)) {
            router.push("/");
          }
          router.push(`?${queryParamKey}=${keyword}`);
        }}
        className="w-full pl-4"
      />
    </CAppBar>
  );
}

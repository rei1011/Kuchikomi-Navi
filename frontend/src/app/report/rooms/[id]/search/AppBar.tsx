"use client";

import { AppBar as CAppBar } from "@/component/AppBar";
import { Menu } from "@/component/Menu";
import { SearchField } from "@/component/SearchField";
import { isBlank } from "@/utils/string-utils";
import { useRouter, useSearchParams } from "next/navigation";

const queryParamKey = "keyword";

export default function AppBar() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const keyword = searchParams.get(queryParamKey);
  return (
    <div className="flex flex-col w-full">
      <CAppBar>
        <Menu />
      </CAppBar>
      <SearchField
        className="w-full px-4"
        submit={(keyword: string | null) => {
          if (isBlank(keyword)) {
            router.push("/");
          }
          router.push(`?${queryParamKey}=${keyword}`);
        }}
        defaultValue={null}
        isOpen={true}
      />
    </div>
  );
}

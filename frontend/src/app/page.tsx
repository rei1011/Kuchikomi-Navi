import { Main } from "@/component/Main";
import { AppBar } from "./home/AppBar";
import { StoreList } from "./home/StoreList";

type SearchParamsType = { [key: string]: string | undefined };

export default function Home({
  searchParams,
}: {
  searchParams: SearchParamsType;
}) {
  return (
    <Main>
      <div className="flex flex-col gap-4 w-full">
        <AppBar />
        <StoreList keyword={searchParams["keyword"]} />
      </div>
    </Main>
  );
}

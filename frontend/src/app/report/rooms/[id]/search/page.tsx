import { Main } from "@/component/Main";
import AppBar from "./AppBar";
import { StoreListWrapper } from "./StoreListWrapper";

type SearchParamsType = { [key: string]: string | undefined };

export default function ReportSearch({
  searchParams,
}: {
  searchParams: SearchParamsType;
}) {
  return (
    <Main>
      <AppBar />
      <StoreListWrapper keyword={searchParams["keyword"]} />
    </Main>
  );
}

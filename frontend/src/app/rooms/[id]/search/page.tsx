import { Main } from "@/component/Main";
import AppBar from "./AppBar";
import { StoreListWrapper } from "./StoreListWrapper";

type SearchParamsType = { [key: string]: string | undefined };

export default async function MessageSearch({
  searchParams,
  params,
}: {
  searchParams: SearchParamsType;
  params: Promise<{ id: string }>;
}) {
  const roomId = (await params).id;
  return (
    <Main>
      <AppBar />
      <StoreListWrapper keyword={searchParams["keyword"]} roomId={roomId} />
    </Main>
  );
}

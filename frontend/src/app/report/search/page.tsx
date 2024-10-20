import AppBar from "./AppBar";
import { StoreList } from "./StoreList";

type SearchParamsType = { [key: string]: string | undefined };

export default function ReportSearch({
  searchParams,
}: {
  searchParams: SearchParamsType;
}) {
  return (
    <main className="flex min-h-screen flex-col items-center py-4">
      <AppBar />
      <StoreList keyword={searchParams["keyword"]} />
    </main>
  );
}

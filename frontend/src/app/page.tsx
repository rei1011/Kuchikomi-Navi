import { AppBar } from "./home/AppBar";
import { StoreList } from "./home/StoreList";

type SearchParamsType = { [key: string]: string | undefined };

export default function Home({
  searchParams,
}: {
  searchParams: SearchParamsType;
}) {
  console.log("logging in home")
  return (
    <main className="flex min-h-screen flex-col items-center py-4">
      <div className="flex flex-col gap-4 w-full">
        <AppBar />
        <StoreList keyword={searchParams["keyword"]} />
      </div>
    </main>
  );
}

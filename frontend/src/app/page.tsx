import { SearchBar } from "./home/SearchBar";
import { StoreList } from "./home/StoreList";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <SearchBar />
      <StoreList />
    </main>
  );
}

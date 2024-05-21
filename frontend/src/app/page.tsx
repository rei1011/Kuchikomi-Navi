import { AppBar } from "./home/AppBar";
import { StoreList } from "./home/StoreList";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center py-4">
      <div className="flex flex-col gap-4">
        <AppBar />
        <StoreList />
      </div>
    </main>
  );
}

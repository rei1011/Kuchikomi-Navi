import { AppBar } from "./home/AppBar";
import { StoreList } from "./home/StoreList";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center">
      <AppBar />
      <StoreList />
    </main>
  );
}

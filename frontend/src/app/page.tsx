import { Comments } from "./Comments";
import { ServerComments } from "./ServerComments";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <Comments />
      <ServerComments />
    </main>
  );
}

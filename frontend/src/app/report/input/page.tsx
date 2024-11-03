import { AddStoreSection } from "./AddStoreSection";
import { AppBar } from "./AppBar";
import { ChatSection } from "./ChatSection";
import { SendMessageSection } from "./SendMessageSection";

export default function ReportInput() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between pt-4 h-full">
      <div className="flex flex-col gap-4 w-full h-full">
        <AppBar />
        <div className="flex flex-col gap-8 px-4 w-full justify-between overscroll-y-auto">
          <AddStoreSection />
          <ChatSection />
        </div>
      </div>
      <SendMessageSection />
    </main>
  );
}
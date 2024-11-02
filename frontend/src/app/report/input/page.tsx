import { AddStoreSection } from "./AddStoreSection";
import { AppBar } from "./AppBar";
import { ChatSection } from "./ChatSection";
import { ExecuteButton } from "./ExecuteButton";
import { InputHowToCompareSection } from "./InputHowToCompareSection";
import { ReportResult } from "./ReportResult";

export default function ReportInput() {
  return (
    <main className="flex min-h-screen flex-col items-center py-4">
      <div className="flex flex-col gap-4 w-full">
        <AppBar />
        <div className="flex flex-col gap-8 w-full px-4">
          <AddStoreSection />
          <InputHowToCompareSection />
          <ExecuteButton />
          <ReportResult />
          <ChatSection />
        </div>
      </div>
    </main>
  );
}

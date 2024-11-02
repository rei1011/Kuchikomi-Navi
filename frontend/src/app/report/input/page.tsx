import { AddStoreArea } from "./AddStoreArea";
import { AppBar } from "./AppBar";
import { ExecuteButton } from "./ExecuteButton";
import { InputHowToCompareArea } from "./InputHowToCompareArea";
import { ReportResult } from "./ReportResult";

export default function ReportInput() {
  return (
    <main className="flex min-h-screen flex-col items-center py-4">
      <div className="flex flex-col gap-4 w-full">
        <AppBar />
        <div className="flex flex-col gap-8 w-full px-4">
          <AddStoreArea />
          <InputHowToCompareArea />
          <ExecuteButton />
          <ReportResult />
        </div>
      </div>
    </main>
  );
}

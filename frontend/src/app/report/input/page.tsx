import { AppBar } from "@/component/AppBar";
import { AddStoreArea } from "./AddStoreArea";
import { ExecuteButton } from "./ExecuteButton";
import { InputHowToCompareArea } from "./InputHowToCompareArea";

export default function ReportInput() {
  return (
    <main className="flex min-h-screen flex-col items-center py-4">
      <div className="flex flex-col gap-4 w-full">
        <AppBar />
        <div className="flex flex-col gap-4 w-full px-4">
          <AddStoreArea />
          <InputHowToCompareArea />
          <ExecuteButton />
        </div>
      </div>
    </main>
  );
}

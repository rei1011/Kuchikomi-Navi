import { AppBarWithMenu } from "@/component/AppBarWithMenu";
import { Main } from "@/component/Main";
import { AddStoreSection } from "./AddStoreSection";
import { ChatSection } from "./ChatSection";
import { SendMessageSection } from "./SendMessageSection";

export default function ReportInput() {
  return (
    <Main paddingBottom={false}>
      <div className="flex flex-col gap-4 w-full h-full">
        <AppBarWithMenu />
        <div className="flex flex-col gap-8 px-4 w-full justify-between overscroll-y-auto">
          <AddStoreSection />
          <ChatSection />
        </div>
      </div>
      <SendMessageSection />
    </Main>
  );
}

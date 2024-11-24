import { AppBarWithMenu } from "@/component/AppBarWithMenu";
import { Main } from "@/component/Main";
import { AddStoreSection } from "./AddStoreSection";
import { ChatSection } from "./ChatSection";
import { SendMessageSection } from "./SendMessageSection";

export default async function ReportInput({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const id = (await params).id;
  return (
    <Main paddingBottom={false}>
      <div className="flex flex-col gap-4 w-full h-full">
        <AppBarWithMenu />
        <div className="flex flex-col gap-8 px-4 w-full justify-between overscroll-y-auto">
          <AddStoreSection id={id} />
          <ChatSection roomId={id} />
        </div>
      </div>
      <SendMessageSection />
    </Main>
  );
}

import { AppBarWithMenu } from "@/component/AppBarWithMenu";
import { Main } from "@/component/Main";
import { RoomListWrapper } from "./RoomListWrapper";
import { StartChatButton } from "./StartChatButton";

export default function ReportRoom() {
  return (
    <Main>
      <AppBarWithMenu />
      <div className="px-4 w-full">
        <StartChatButton />
        <RoomListWrapper />
      </div>
    </Main>
  );
}

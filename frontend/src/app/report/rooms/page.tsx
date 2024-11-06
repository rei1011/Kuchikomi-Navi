import { AppBarWithMenu } from "@/component/AppBarWithMenu";
import { Main } from "@/component/Main";
import { RoomListWrapper } from "./RoomListWrapper";

export default function ReportRoom() {
  return (
    <Main>
      <AppBarWithMenu />
      <RoomListWrapper />
    </Main>
  );
}

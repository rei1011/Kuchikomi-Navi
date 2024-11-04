import { AppBarWithMenu } from "@/component/AppBarWithMenu";
import { Main } from "@/component/Main";
import { RoomList } from "./RoomList";

export default function ReportRoom() {
  return (
    <Main>
      <AppBarWithMenu />
      <RoomList />
    </Main>
  );
}

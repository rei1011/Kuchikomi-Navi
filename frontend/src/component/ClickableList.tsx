import { deleteRoom } from "@/api/report/rooms/api";
import ChatIcon from "@mui/icons-material/Chat";
import DeleteIcon from "@mui/icons-material/Delete";
import ModeEditIcon from "@mui/icons-material/ModeEdit";
import List from "@mui/material/List";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemText from "@mui/material/ListItemText";
import { useRouter } from "next/navigation";
import { EditChatRoomButton } from "./EditChatRoomButton";

type Props = {
  items: { name: string; id: number }[];
};

export const ClickableList = (props: Props) => {
  const { items } = props;
  const router = useRouter();

  return (
    <List className="flex flex-col gap-4">
      {items.map((item) => {
        const { name, id } = item;
        return (
          <ListItemButton
            key={id}
            className="bg-secondary rounded-lg py-3 justify-between"
            onClick={() => {
              router.push(`/report/rooms/${id}/input`);
            }}
          >
            <div className="flex items-center">
              <ChatIcon className="bg-primary" />
              <ListItemText primary={name} />
            </div>
            <EditChatRoomButton
              options={[
                {
                  title: "名前を変更する",
                  icon: <ModeEditIcon />,
                  callback: () => {},
                },
                {
                  title: "削除する",
                  icon: <DeleteIcon />,
                  callback: async () => {
                    await deleteRoom(id.toString());
                  },
                  isDanger: true,
                },
              ]}
            />
          </ListItemButton>
        );
      })}
    </List>
  );
};

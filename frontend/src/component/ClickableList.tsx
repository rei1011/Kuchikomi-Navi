import { deleteRoom } from "@/api/report/rooms/api";
import ChatIcon from "@mui/icons-material/Chat";
import DeleteIcon from "@mui/icons-material/Delete";
import ModeEditIcon from "@mui/icons-material/ModeEdit";
import List from "@mui/material/List";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemText from "@mui/material/ListItemText";
import TextField from "@mui/material/TextField";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { EditChatRoomButton } from "./EditChatRoomButton";

type Props = {
  items: { name: string; id: number }[];
};

export const ClickableList = (props: Props) => {
  const { items } = props;
  const router = useRouter();
  const [editableRoom, setEditableRoom] = useState<number | undefined>(
    undefined
  );

  return (
    <List className="flex flex-col gap-4">
      {items.map((item) => {
        const { name, id } = item;
        return (
          <ListItemButton
            key={id}
            className="bg-secondary rounded-lg py-5 justify-between"
            onClick={() => {
              if (editableRoom === id) {
                return;
              }
              router.push(`/report/rooms/${id}/input`);
            }}
          >
            <div className="flex items-center w-full">
              <ChatIcon />
              <div className="px-4 w-full">
                {editableRoom === id ? (
                  <form
                    method="post"
                    onSubmit={(e) => {
                      e.preventDefault();
                      console.log("change name !!");
                    }}
                  >
                    <TextField
                      hiddenLabel
                      defaultValue={name}
                      className="h-full w-full"
                      variant="standard"
                      size="small"
                    />
                  </form>
                ) : (
                  <ListItemText primary={name} />
                )}
              </div>
            </div>
            <EditChatRoomButton
              options={[
                {
                  title: "名前を変更する",
                  icon: <ModeEditIcon />,
                  callback: () => {
                    setEditableRoom(id);
                  },
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

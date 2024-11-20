import { deleteRoom, updateRoom } from "@/api/report/rooms/api";
import { Rooms } from "@/api/report/rooms/type";
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
  items: Rooms;
};

export const ClickableList = (props: Props) => {
  const { items } = props;
  const router = useRouter();
  const [isEditableRoom, setIsEditableRoom] = useState<number | undefined>(
    undefined
  );

  return (
    <List className="flex flex-col gap-4">
      {items.map((item) => {
        const { name, id, store1_id: store1Id, store2_id: store2Id } = item;
        return (
          <ListItemButton
            key={id}
            className="bg-secondary rounded-lg py-5 justify-between"
            onClick={() => {
              if (isEditableRoom === id) {
                return;
              }
              router.push(`/report/rooms/${id}/input`);
            }}
          >
            <div className="flex items-center w-full">
              <ChatIcon />
              <div className="px-4 w-full">
                {isEditableRoom === id ? (
                  <form
                    method="post"
                    onSubmit={async (e) => {
                      e.preventDefault();
                      await updateRoom({
                        roomId: id.toString(),
                        // TODO: Fix
                        // @ts-ignore
                        name: e.target[0].value,
                        store1Id,
                        store2Id,
                      });
                      setIsEditableRoom(undefined);
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
                    setIsEditableRoom(id);
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

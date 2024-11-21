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
import { Dispatch, SetStateAction, useEffect, useRef, useState } from "react";
import { EditChatRoomButton } from "./EditChatRoomButton";

type Props = {
  items: Rooms;
};

export const ClickableList = (props: Props) => {
  const { items } = props;
  const router = useRouter();
  const [isEditableRoomId, setIsEditableRoomId] = useState<number | undefined>(
    undefined
  );
  const formInputRef = useRef<HTMLDivElement>(null);

  // 範囲外をタップした時に編集モードを終了させるための処理
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent | TouchEvent) => {
      const target = event.target as Node | null;
      if (
        isEditableRoomId &&
        formInputRef.current &&
        !formInputRef.current.contains(target)
      ) {
        setIsEditableRoomId(undefined);
      }
    };

    if (isEditableRoomId) {
      document.addEventListener("mousedown", handleClickOutside);
      document.addEventListener("touchstart", handleClickOutside);
    }

    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
      document.removeEventListener("touchstart", handleClickOutside);
    };
  }, [isEditableRoomId]);

  return (
    <List className="flex flex-col gap-4">
      {items.map((item) => {
        const { name, id, store1_id: store1Id, store2_id: store2Id } = item;
        return (
          <div
            key={id}
            className="flex justify-between bg-secondary rounded-lg items-center py-2 px-4"
          >
            <ListItemButton
              disableRipple
              disableGutters={true}
              onClick={() => {
                if (isEditableRoomId === id) {
                  return;
                }
                router.push(`/report/rooms/${id}/input`);
              }}
            >
              <div className="flex items-center">
                <ChatIcon />
                <div className="px-4" ref={formInputRef}>
                  {isEditableRoomId === id ? (
                    <ListItemFormInput
                      id={id}
                      store1Id={store1Id}
                      store2Id={store2Id}
                      setIsEditableRoom={setIsEditableRoomId}
                      name={name}
                    />
                  ) : (
                    <ListItemText primary={name} />
                  )}
                </div>
              </div>
            </ListItemButton>
            <div className="justify-between">
              <EditChatRoomButton
                options={[
                  {
                    title: "名前を変更する",
                    icon: <ModeEditIcon />,
                    callback: () => {
                      setIsEditableRoomId(id);
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
            </div>
          </div>
        );
      })}
    </List>
  );
};

type ListItemFormInputProps = {
  id: number;
  store1Id: number | null;
  store2Id: number | null;
  setIsEditableRoom: Dispatch<SetStateAction<number | undefined>>;
  name: string | null;
};

function ListItemFormInput(props: ListItemFormInputProps) {
  const { id, store1Id, store2Id, setIsEditableRoom, name } = props;
  return (
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
  );
}

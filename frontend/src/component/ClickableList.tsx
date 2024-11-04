import ChatIcon from "@mui/icons-material/Chat";
import List from "@mui/material/List";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import { useRouter } from "next/navigation";

type Props = {
  items: { title: string; roomId: string }[];
};

export const ClickableList = (props: Props) => {
  const { items } = props;
  const router = useRouter();

  return (
    <List>
      {items.map((item) => {
        const { title, roomId } = item;
        return (
          <ListItemButton
            key={roomId}
            onClick={() => {
              router.push(`/room/${roomId}`);
            }}
          >
            <ListItemIcon>
              <ChatIcon />
            </ListItemIcon>
            <ListItemText primary={title} />
          </ListItemButton>
        );
      })}
    </List>
  );
};

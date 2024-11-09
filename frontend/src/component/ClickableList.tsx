import ChatIcon from "@mui/icons-material/Chat";
import List from "@mui/material/List";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import { useRouter } from "next/navigation";

type Props = {
  items: { name: string; id: number }[];
};

export const ClickableList = (props: Props) => {
  const { items } = props;
  const router = useRouter();

  return (
    <List>
      {items.map((item) => {
        const { name, id } = item;
        return (
          <ListItemButton
            key={id}
            onClick={() => {
              router.push(`/report/rooms/${id}/input`);
            }}
          >
            <ListItemIcon>
              <ChatIcon />
            </ListItemIcon>
            <ListItemText primary={name} />
          </ListItemButton>
        );
      })}
    </List>
  );
};

import {
  Divider,
  ListItem,
  ListItemText,
  List as MuiList,
  Typography,
} from "@mui/material";
import { List } from "./List";

type ListProps = {
  storeName: string;
  prefecture: string;
  municipality: string;
  open: { from?: string; to?: string };
};

export function ShopInfo(props: ListProps) {
  const { storeName, prefecture, municipality, open } = props;
  return (
    <MuiList>
      <ListItem>
        <ListItemText>
          <Typography component="div" variant="h6">
            {storeName}
          </Typography>
        </ListItemText>
      </ListItem>
      <Divider variant="fullWidth" component="li" />
      <List
        items={[
          { title: "Location", content: `${prefecture} ${municipality}` },
          {
            title: "Open",
            content:
              open.from == null && open.to == null
                ? "不明"
                : `${open.from ?? ""} - ${open.to ?? ""}`,
          },
        ]}
      />
    </MuiList>
  );
}

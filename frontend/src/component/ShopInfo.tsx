import {
  Divider,
  List,
  ListItem,
  ListItemText,
  Typography,
} from "@mui/material";

type ListProps = {
  storeName: string;
  prefecture: string;
  municipality: string;
};

export function ShopInfo(props: ListProps) {
  const { storeName, prefecture, municipality } = props;
  return (
    <List>
      <ListItem>
        <ListItemText>
          <Typography component="div" variant="h6">
            {storeName}
          </Typography>
        </ListItemText>
      </ListItem>
      <Divider variant="fullWidth" component="li" />
      <ListItem>
        <ListItemText>
          <Typography
            variant="subtitle1"
            color="text.secondary"
            component="div"
          >
            {`${prefecture} ${municipality}`}
          </Typography>
        </ListItemText>
      </ListItem>
    </List>
  );
}

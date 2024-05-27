import {
  ListItem,
  ListItemText,
  Divider as MuiDivider,
  List as MuiList,
  Typography,
} from "@mui/material";
import React from "react";

type ListProps = {
  items: { title: string; content: string }[];
};

export function List(props: ListProps) {
  const { items } = props;
  return (
    <MuiList>
      {items.map((item, index) => {
        return (
          <React.Fragment key={`${item.title}_${index}`}>
            <ListItem>
              <ListItemText>
                <div className="flex">
                  <div className="w-20">
                    <Typography
                      variant="subtitle1"
                      color="text.black"
                      component="span"
                    >
                      <span className="font-semibold">{item.title}</span>
                    </Typography>
                  </div>

                  <Typography
                    variant="subtitle1"
                    color="text.black"
                    component="span"
                  >
                    <span className="font-light">{item.content}</span>
                  </Typography>
                </div>
              </ListItemText>
            </ListItem>
            <Divider isLast={index + 1 === items.length} />
          </React.Fragment>
        );
      })}
    </MuiList>
  );
}

type DividerProps = {
  isLast: boolean;
};

function Divider(props: DividerProps) {
  const { isLast } = props;
  if (isLast) {
    return <></>;
  }
  return <MuiDivider variant="fullWidth" component="li" />;
}

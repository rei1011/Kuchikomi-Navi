import MoreHorizIcon from "@mui/icons-material/MoreHoriz";
import Menu from "@mui/material/Menu";
import MenuItem from "@mui/material/MenuItem";
import React, { ReactNode, useCallback, useState } from "react";

type Props = {
  options: {
    title: string;
    icon: ReactNode;
    callback: () => void;
    isDanger?: boolean;
  }[];
};

export const EditChatRoomButton = (props: Props) => {
  const { options } = props;
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const open = Boolean(anchorEl);
  const handleClickListItem = useCallback(
    (event: React.MouseEvent<HTMLElement>) => {
      setAnchorEl(event.currentTarget);
    },
    []
  );
  const handleClose = useCallback(() => {
    setAnchorEl(null);
  }, []);

  return (
    <>
      <button
        onClick={(e) => {
          e.stopPropagation();
          handleClickListItem(e);
        }}
      >
        <MoreHorizIcon />
      </button>
      <Menu
        id="edit-chat-room-menu"
        anchorEl={anchorEl}
        open={open}
        onClose={handleClose}
        MenuListProps={{
          role: "listbox",
        }}
      >
        {options.map((option, index) => (
          <MenuItem
            key={`edit_chat_room_button_${index}`}
            onClick={(e) => {
              e.stopPropagation();
              option.callback();
              handleClose();
            }}
          >
            <div className={`flex gap-2 ${option.isDanger && "text-red"}`}>
              {option.icon}
              {option.title}
            </div>
          </MenuItem>
        ))}
      </Menu>
    </>
  );
};

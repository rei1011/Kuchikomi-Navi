import { EditChatRoomButton } from "@/component/EditChatRoomButton";
import DeleteIcon from "@mui/icons-material/Delete";
import ModeEditIcon from "@mui/icons-material/ModeEdit";

import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/EditChatRoomButton",
  component: EditChatRoomButton,
  tags: ["autodocs"],
} satisfies Meta<typeof EditChatRoomButton>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    options: [
      { title: "名前を変更する", icon: <ModeEditIcon />, callback: () => {} },
      {
        title: "削除する",
        icon: <DeleteIcon />,
        callback: () => {},
        isDanger: true,
      },
    ],
  },
};

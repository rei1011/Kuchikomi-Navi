import { ClickableList } from "@/component/ClickableList";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "ClickableList",
  component: ClickableList,
  tags: ["autodocs"],
} satisfies Meta<typeof ClickableList>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    items: [
      { title: "Basic認証のエラー対応", roomId: "uuid1" },
      { title: "美味しいカレーの作り方", roomId: "uuid2" },
      { title: "公的医療保険の例", roomId: "uuid3" },
    ],
  },
};

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
      { name: "Basic認証のエラー対応", id: 1 },
      { name: "美味しいカレーの作り方", id: 2 },
      { name: "公的医療保険の例", id: 3 },
    ],
  },
};

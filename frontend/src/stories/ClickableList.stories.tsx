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
      {
        name: "Basic認証のエラー対応", id: 1,
        user_id: 0,
        created_at: "",
        updated_at: "",
        store1_id: null,
        store2_id: null
      },
      {
        name: "美味しいカレーの作り方", id: 2,
        user_id: 0,
        created_at: "",
        updated_at: "",
        store1_id: null,
        store2_id: null
      },
      {
        name: "公的医療保険の例", id: 3,
        user_id: 0,
        created_at: "",
        updated_at: "",
        store1_id: null,
        store2_id: null
      },
    ],
  },
};

import { ShopInfo } from "@/component/ShopInfo";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/ShopInfo",
  component: ShopInfo,
  tags: ["autodocs"],
} satisfies Meta<typeof ShopInfo>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    storeName: "東京店",
    prefecture: "東京",
    municipality: "池袋",
  },
};

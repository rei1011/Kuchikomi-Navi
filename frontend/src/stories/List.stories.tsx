import { List } from "@/component/List";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/List",
  component: List,
  tags: ["autodocs"],
} satisfies Meta<typeof List>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    items: [
      { title: "Location", content: "東京 池袋" },
      { title: "Open", content: "10:00 - 19:00" },
    ],
  },
};

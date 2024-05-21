import { AppBar } from "@/component/AppBar";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/AppBar",
  component: AppBar,
  tags: ["autodocs"],
} satisfies Meta<typeof AppBar>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {};

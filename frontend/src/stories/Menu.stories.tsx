import { Menu } from "@/component/Menu";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/Menu",
  component: Menu,
  tags: ["autodocs"],
} satisfies Meta<typeof Menu>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {};

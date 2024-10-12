import { AddStore } from "@/component/AddStore";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/AddStore",
  component: AddStore,
  tags: ["autodocs"],
} satisfies Meta<typeof AddStore>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {};

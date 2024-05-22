import { EmptyView } from "@/component/EmptyView";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/EmptyView",
  component: EmptyView,
  tags: ["autodocs"],
} satisfies Meta<typeof EmptyView>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {};

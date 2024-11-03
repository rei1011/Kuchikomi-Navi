import { ChatMessage } from "@/component/ChatMessage";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/ChatMessage",
  component: ChatMessage,
  tags: ["autodocs"],
} satisfies Meta<typeof ChatMessage>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    role: "user",
  },
};

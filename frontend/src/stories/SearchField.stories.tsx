import { SearchField } from "@/component/SearchField";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/SearchField",
  component: SearchField,
  tags: ["autodocs"],
} satisfies Meta<typeof SearchField>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    submit: console.log,
    defaultValue: "",
    isOpen: true,
    placeholder: "渋谷",
  },
};

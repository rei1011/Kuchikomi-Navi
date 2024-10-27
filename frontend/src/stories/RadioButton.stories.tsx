import { RadioButtonGroup } from "@/component/RadioButtonGroup";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/RadioButton",
  component: RadioButtonGroup,
  tags: ["autodocs"],
} satisfies Meta<typeof RadioButtonGroup>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    label: "Radio Button",
    defaultValue: "1",
    options: [
      { value: "1", label: "Option 1" },
      { value: "2", label: "Option 2" },
      { value: "3", label: "Option 3" },
    ],
  },
};

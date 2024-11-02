import { StickyInput } from "@/component/StickyInput";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/StickyInput",
  component: StickyInput,
  tags: ["autodocs"],
} satisfies Meta<typeof StickyInput>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    onChange: (e) => {
      console.log(e.target.value);
    },
    onSubmit: () => {
      console.log("submit!!");
    },
  },
};

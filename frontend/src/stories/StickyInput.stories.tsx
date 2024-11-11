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
    value: "おすすめのお店を紹介して",
    disabled: false,
  },
  render: (args) => (
    <div className="flex flex-col h-32">
      {[...Array(10)].map((_, index) => (
        <div key={index}>test</div>
      ))}
      <StickyInput {...args} />
    </div>
  ),
};

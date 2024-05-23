import { Credit } from "@/component/Credit";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/Credit",
  component: Credit,
  tags: ["autodocs"],
} satisfies Meta<typeof Credit>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    author: "Game-icons.net",
    imageName: "slavery-whip",
    licenseName: "Creative Commons 3.0 BY license",
    licenseUrl: new URL("https://creativecommons.org/licenses/by/3.0/"),
  },
};

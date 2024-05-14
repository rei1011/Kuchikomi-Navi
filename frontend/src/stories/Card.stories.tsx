import { Card } from "@/component/Card";
import { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Components/Card",
  component: Card,
  tags: ["autodocs"],
} satisfies Meta<typeof Card>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    storeName: "西川口前立腺研究所",
    address: {
      prefecture: "埼玉",
      municipality: "西川口",
    },
    homePageUri: new URL("https://www.nk-zenken.com/"),
    imageUri: new URL(
      "https://img.fujoho.jp/public/img_shop_list_ad_img/slai_33161_5e057b1fc97735.00376143.jpg"
    ),
  },
};

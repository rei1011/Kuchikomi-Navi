import { getStore } from "@/api/store/api";
import { EmptyView } from "@/component/EmptyView";
import { StoreListForm } from "./StoreListForm";

type StoreListProsp = {
  keyword?: string;
  roomId: string;
};

export async function StoreListWrapper(props: StoreListProsp) {
  const { keyword, roomId } = props;
  const stores = await getStore(keyword);
  const options = stores.list.map((e) => {
    return {
      value: e.home_page,
      label: e.store_name,
    };
  });

  if (stores.list.length === 0) {
    return <EmptyView className="p-4" />;
  }

  return <StoreListForm options={options} roomId={roomId} />;
}

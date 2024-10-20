import { getStore } from "@/api/store/api";
import { EmptyView } from "@/component/EmptyView";

type StoreListProsp = {
  keyword?: string;
};

export async function StoreList(props: StoreListProsp) {
  const { keyword } = props;
  const stores = await getStore(keyword);

  if (stores.list.length === 0) {
    return <EmptyView />;
  }

  return (
    <div>
      {stores.list.map((store) => {
        return (
          <div key={store.home_page}>
            <div>{store.store_name}</div>
          </div>
        );
      })}
    </div>
  );
}

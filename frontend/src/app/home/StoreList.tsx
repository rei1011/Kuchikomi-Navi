import { getStore } from "@/api/store/api";
import { Card } from "@/component/Card";

export async function StoreList() {
  const stores = await getStore();

  return (
    <div className="flex flex-col gap-y-2">
      店舗一覧
      {stores.map((store) => {
        return (
          <Card
            key={store.id}
            storeName={store.store_name}
            imageUri={new URL(store.store_image)}
            homePageUri={new URL(store.home_page)}
            address={store.address}
          />
        );
      })}
    </div>
  );
}

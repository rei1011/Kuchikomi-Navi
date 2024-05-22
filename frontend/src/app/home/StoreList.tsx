import { getStore } from "@/api/store/api";
import { Card } from "@/component/Card";
import { stringToUrl } from "@/utils/string-utils";

export async function StoreList() {
  const stores = await getStore();

  return (
    <div className="flex flex-col gap-y-2 px-4">
      {stores.list.map((store) => {
        return (
          <Card
            key={store.home_page}
            storeName={store.store_name}
            imageUri={stringToUrl(store.store_image)}
            homePageUri={stringToUrl(store.home_page)}
            address={store.address}
          />
        );
      })}
    </div>
  );
}

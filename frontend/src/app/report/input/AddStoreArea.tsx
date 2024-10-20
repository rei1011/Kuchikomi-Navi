import { AddStore } from "@/component/AddStore";
import Link from "next/link";

export const AddStoreArea = () => {
  return (
    <div className="flex flex-col gap-8">
      <Link href="/report/search">
        <AddStore />
      </Link>
      <Link href="/report/search">
        <AddStore />
      </Link>
    </div>
  );
};

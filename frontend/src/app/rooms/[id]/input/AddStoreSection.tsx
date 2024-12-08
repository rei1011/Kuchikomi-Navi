"use client";
import { AddStore } from "@/component/AddStore";
import Link from "next/link";
import { useMemo } from "react";
import { useMessageContext } from "../message-context";

type Props = {
  id: string;
};

export const AddStoreSection = (props: Props) => {
  const { id } = props;
  const { setSelectedIndex, selectedStore } = useMessageContext();
  return useMemo(
    () => (
      <section className="flex flex-col gap-4">
        <h1 className="text-xl">店舗を選択</h1>
        <div className="flex flex-col gap-8">
          <Link
            href={`/rooms/${id}/search`}
            onClick={() => setSelectedIndex(0)}
          >
            <AddStore selectedStore={selectedStore[0]?.label} />
          </Link>
          <Link
            href={`/rooms/${id}/search`}
            onClick={() => setSelectedIndex(1)}
          >
            <AddStore selectedStore={selectedStore[1]?.label} />
          </Link>
        </div>
      </section>
    ),
    [id, selectedStore, setSelectedIndex]
  );
};

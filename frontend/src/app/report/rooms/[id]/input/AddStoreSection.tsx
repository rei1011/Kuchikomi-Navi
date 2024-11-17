"use client";
import { useReportContext } from "@/app/report-context";
import { AddStore } from "@/component/AddStore";
import Link from "next/link";
import { useMemo } from "react";

type Props = {
  id: string;
};

export const AddStoreSection = (props: Props) => {
  const { id } = props;
  const { setSelectedIndex, selectedStore } = useReportContext();
  return useMemo(
    () => (
      <section className="flex flex-col gap-4">
        <h1 className="text-xl">店舗を選択</h1>
        <div className="flex flex-col gap-8">
          <Link
            href={`/report/rooms/${id}/search`}
            onClick={() => setSelectedIndex(0)}
          >
            <AddStore selectedStore={selectedStore[0]?.label} />
          </Link>
          <Link
            href={`/report/rooms/${id}/search`}
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

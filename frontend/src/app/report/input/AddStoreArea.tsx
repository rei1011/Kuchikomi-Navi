"use client";
import { useReportContext } from "@/app/report-context";
import { AddStore } from "@/component/AddStore";
import Link from "next/link";

export const AddStoreArea = () => {
  const { setSelectedIndex, selectedStore } = useReportContext();
  return (
    <div className="flex flex-col gap-8">
      <Link href="/report/search" onClick={() => setSelectedIndex(0)}>
        <AddStore selectedStore={selectedStore[0]} />
      </Link>
      <Link href="/report/search" onClick={() => setSelectedIndex(1)}>
        <AddStore selectedStore={selectedStore[1]} />
      </Link>
    </div>
  );
};

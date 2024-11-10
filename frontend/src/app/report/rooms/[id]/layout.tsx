import { findRoomById } from "@/api/report/rooms/api";
import { ReportContextProvider } from "@/app/report-context";

export default async function ReportLayout({
  params,
  children,
}: {
  params: Promise<{ id: string }>;
  children: React.ReactNode;
}) {
  const id = (await params).id;
  const room = await findRoomById(id);
  return (
    <ReportContextProvider store1={room.store1} store2={room.store2}>
      {children}
    </ReportContextProvider>
  );
}

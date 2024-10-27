import { ReportContextProvider } from "../report-context";

export default function ReportLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <ReportContextProvider>{children}</ReportContextProvider>;
}

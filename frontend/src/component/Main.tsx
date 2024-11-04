import { PropsWithChildren } from "react";

type Props = {
  paddingBottom?: boolean;
} & PropsWithChildren;

export const Main = ({ children, paddingBottom = true }: Props) => {
  return (
    <main
      className={`h-full flex min-h-screen flex-col items-center ${paddingBottom ? "py-4" : "pt-4"}`}
    >
      {children}
    </main>
  );
};

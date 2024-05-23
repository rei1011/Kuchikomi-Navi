import { PropsWithChildren } from "react";

type CreditProps = {
  author: string;
  imageName: string;
  licenseName: string;
  licenseUrl: URL;
  className?: string;
};

export function Credit(props: PropsWithChildren<CreditProps>) {
  const { children, author, imageName, licenseName, licenseUrl, className } =
    props;
  return (
    <div className={`flex flex-col items-center gap-2 text-black ${className}`}>
      {children}
      <span>
        {imageName} ©️ {author} (
        <a href={licenseUrl.href} className="underline">
          {licenseName}
        </a>
        )
      </span>
    </div>
  );
}

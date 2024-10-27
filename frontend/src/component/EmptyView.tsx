import { SlaveryWhipSvgrepoCom } from "@/component/icons";
import { Typography } from "@mui/material";
import { Credit } from "./Credit";

type Props = {
  className?: string;
};

export function EmptyView(props: Props) {
  const { className } = props;
  return (
    <div className={`flex flex-col items-center ${className}`}>
      <Typography variant="h4" className="text-black">
        Not Found !!
      </Typography>
      <Credit
        className="px-4"
        author="Game-icons.net"
        imageName="slavery-whip"
        licenseName="Creative Commons 3.0 BY license"
        licenseUrl={new URL("https://creativecommons.org/licenses/by/3.0/")}
      >
        <SlaveryWhipSvgrepoCom
          style={{ width: "256px", height: "256px" }}
          className="opacity-80"
        />
      </Credit>
    </div>
  );
}

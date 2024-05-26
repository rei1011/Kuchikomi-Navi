import {
  Box,
  CardContent,
  CardMedia,
  Link,
  Card as MuiCard,
} from "@mui/material";
import { ShopInfo } from "./ShopInfo";

export type CardProps = {
  storeName: string;
  homePageUri?: URL;
  address: Address;
  imageUri?: URL;
  open: {
    from: string;
    to: string;
  };
};

type Address = {
  prefecture: string;
  municipality: string;
};

export function Card(props: CardProps) {
  const { storeName, homePageUri, address, imageUri, open } = props;
  return (
    <Link
      href={homePageUri?.href}
      target="_blank"
      rel="noopener"
      style={{ textDecoration: "none" }}
    >
      <MuiCard sx={{ width: "100%", borderRadius: 2 }} elevation={0}>
        <Media imageUri={imageUri} />
        <Box
          sx={{
            display: "flex",
            flexDirection: "column",
          }}
        >
          <CardContent
            style={{ paddingBottom: "0" }}
            sx={{
              flex: "1 0 auto",
              alignContent: "center",
              padding: "4px",
            }}
          >
            <ShopInfo
              storeName={storeName}
              prefecture={address.prefecture}
              municipality={address.municipality}
              open={open}
            />
          </CardContent>
        </Box>
      </MuiCard>
    </Link>
  );
}

/**
 * 店舗の画像を表示
 * @param param0
 * @returns
 */
function Media({ imageUri }: { imageUri?: URL }) {
  if (imageUri == null) {
    return <></>;
  }
  return (
    <CardMedia
      component="img"
      sx={{ width: 1, maxHeight: "200px" }}
      image={imageUri.href}
      alt="Live from space album cover"
    />
  );
}

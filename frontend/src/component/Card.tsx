import {
  Box,
  CardContent,
  CardMedia,
  Link,
  Card as MuiCard,
  Typography,
} from "@mui/material";

export type CardProps = {
  storeName: string;
  homePageUri?: URL;
  address: Address;
  imageUri?: URL;
};

type Address = {
  prefecture: string;
  municipality: string;
};

export function Card(props: CardProps) {
  const { storeName, homePageUri, address, imageUri } = props;
  return (
    <MuiCard sx={{ display: "flex", width: "100%" }}>
      <Media imageUri={imageUri} />
      <Box
        sx={{
          display: "flex",
          flexDirection: "column",
        }}
      >
        <CardContent
          sx={{
            flex: "1 0 auto",
            alignContent: "center",
          }}
        >
          <StoreName homePageUri={homePageUri} storeName={storeName} />
          <Typography
            variant="subtitle1"
            color="text.secondary"
            component="div"
          >
            {address.prefecture} {address.municipality}
          </Typography>
        </CardContent>
      </Box>
    </MuiCard>
  );
}

function StoreName({
  homePageUri,
  storeName,
}: {
  homePageUri?: URL;
  storeName: string;
}) {
  const store = (
    <Typography component="div" variant="h5">
      {storeName}
    </Typography>
  );

  if (homePageUri == null) {
    return store;
  }

  return (
    <Link href={homePageUri.href} target="_blank" rel="noopener">
      {store}
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
      sx={{ width: 151 }}
      image={imageUri.href}
      alt="Live from space album cover"
    />
  );
}

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
  homePageUri: URL;
  address: Address;
  imageUri: URL;
};

type Address = {
  prefecture: string;
  municipality: string;
};

export function Card(props: CardProps) {
  const { storeName, homePageUri, address, imageUri } = props;
  return (
    <MuiCard sx={{ display: "flex" }}>
      <CardMedia
        component="img"
        sx={{ width: 151 }}
        image={imageUri.href}
        alt="Live from space album cover"
      />
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
          <Link href={homePageUri.href} target="_blank" rel="noopener">
            <Typography component="div" variant="h5">
              {storeName}
            </Typography>
          </Link>

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

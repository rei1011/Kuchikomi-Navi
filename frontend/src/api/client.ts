import createClient from "openapi-fetch";

export function client<Paths extends {}>() {
  console.log("authentication info");
  console.log(
    `${process.env.BASIC_AUTH_USER}:${process.env.BASIC_AUTH_PASSWORD}`
  );
  return createClient<Paths>({
    baseUrl: process.env.NEXT_PUBLIC_SERVER_HOST,
    next: { revalidate: 10 },
    headers: {
      Authorization:
        "Basic " +
        btoa(
          `${process.env.BASIC_AUTH_USER}:${process.env.BASIC_AUTH_PASSWORD}`
        ),
    },
  });
}

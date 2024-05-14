import createClient from "openapi-fetch";

export function client<Paths extends {}>() {
  return createClient<Paths>({
    baseUrl: process.env.NEXT_PUBLIC_SERVER_HOST,
  });
}

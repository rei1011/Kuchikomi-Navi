import { NextRequest, NextResponse } from "next/server";

export const middleware = (req: NextRequest) => {
  const basicAuth = req.headers.get("authorization");

  if (basicAuth) {
    const authValue = basicAuth.split(" ")[1];

    const [username, password] = atob(authValue).split(":");

    if (
      username === process.env.BASIC_AUTH_USER &&
      password === process.env.BASIC_AUTH_PASSWORD
    ) {
      return NextResponse.next();
    }
  }

  return new NextResponse("Unauthorized", {
    status: 401,
    headers: {
      "WWW-Authenticate": 'Basic realm="Secure Area"',
    },
  });
};

export const config = {
  matcher: ["/"],
};

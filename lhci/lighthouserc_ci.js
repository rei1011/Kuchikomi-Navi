const BASIC_AUTH_USER = process.env.BASIC_AUTH_USER || "";
const BASIC_AUTH_PASSWORD = process.env.BASIC_AUTH_PASSWORD || "";

const basicAuthHeader = `Basic ${Buffer.from(
  `${BASIC_AUTH_USER}:${BASIC_AUTH_PASSWORD}`
).toString("base64")}`;

module.exports = {
  ci: {
    collect: {
      settings: {
        extraHeaders: JSON.stringify({
          Authorization: basicAuthHeader,
        }),
      },
      url: [
        "https://frontend-app-uuwuit3kva-de.a.run.app/",
        "https://frontend-app-uuwuit3kva-de.a.run.app/rooms",
      ],
    },
    upload: {
      target: "lhci",
      serverBaseUrl: "https://lhci-server-uuwuit3kva-de.a.run.app",
      basicAuth: {
        username: BASIC_AUTH_USER,
        password: BASIC_AUTH_PASSWORD,
      },
    },
  },
};

const BASIC_AUTH_USER = process.env.BASIC_AUTH_USER;
const BASIC_AUTH_PASSWORD = process.env.BASIC_AUTH_PASSWORD;

// 環境変数が正しく設定されているか確認
if (!BASIC_AUTH_USER || !BASIC_AUTH_PASSWORD) {
  throw new Error(
    "BASIC_AUTH_USERまたはBASIC_AUTH_PASSWORDが設定されていません。"
  );
}

const basicAuthHeader = `Basic ${Buffer.from(`${BASIC_AUTH_USER}:${BASIC_AUTH_PASSWORD}`).toString("base64")}`;

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
      target: "temporary-public-storage",
    },
  },
};

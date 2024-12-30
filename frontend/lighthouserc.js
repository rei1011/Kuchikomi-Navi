module.exports = {
  ci: {
    collect: {
      settings: {
        extraHeaders: JSON.stringify({
          Authorization: "Basic YnVjaGlyZWk6a3VjaGlrb21pMDExNA==",
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

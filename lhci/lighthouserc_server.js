const BASIC_AUTH_USER = process.env.BASIC_AUTH_USER || "";
const BASIC_AUTH_PASSWORD = process.env.BASIC_AUTH_PASSWORD || "";

module.exports = {
  ci: {
    server: {
      port: 9001,
      storage: {
        storageMethod: "sql",
        sqlDialect: "sqlite",
        sqlDatabasePath: "/data/lhci.db",
      },
      basicAuth: {
        username: BASIC_AUTH_USER,
        password: BASIC_AUTH_PASSWORD,
      },
      deleteOldBuildsCron: [
        {
          // Cloud Runに対して常にCPUを割り当てて、適当な時間で削除してもよさそう
          maxAgeInDays: 1,
          schedule: "* * * * *",
        },
      ],
    },
  },
};

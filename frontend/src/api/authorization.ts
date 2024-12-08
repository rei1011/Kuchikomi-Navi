"use server";

export const authorization = async () => {
  return {
    basicAuthUser: process.env.BASIC_AUTH_USER,
    basicAuthPassword: process.env.BASIC_AUTH_PASSWORD,
  };
};

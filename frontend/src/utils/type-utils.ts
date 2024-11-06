import { paths } from "../../openapi/schema";

type ApiPath = keyof paths;
type Responses = {
  responses: {
    "200": {
      content: {
        "application/json": object;
      };
    };
  };
};

type Request = {
  requestBody: {
    content: {
      "application/json": object;
    };
  };
};

export type ExtractGet<ApiPaths extends ApiPath> =
  paths[ApiPaths]["get"] extends infer T ? T : never;
export type ExtractPost<ApiPaths extends ApiPath> =
  paths[ApiPaths]["post"] extends infer T ? T : never;
export type ExtractPatch<ApiPaths extends ApiPath> =
  paths[ApiPaths]["patch"] extends infer T ? T : never;
export type ExtractResponse<T extends Responses> =
  T["responses"]["200"]["content"]["application/json"];
export type ExtractRequest<T extends Request> =
  T["requestBody"]["content"]["application/json"];

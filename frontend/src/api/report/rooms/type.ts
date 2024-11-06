import { ExtractGet, ExtractResponse } from "@/utils/type-utils";

export type Rooms = ExtractResponse<ExtractGet<"/rooms">>["list"];

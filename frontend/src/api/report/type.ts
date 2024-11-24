import { ExtractGet, ExtractResponse } from "@/utils/type-utils";

export type Messages = ExtractResponse<ExtractGet<"/rooms/{room_id}/messages">>;

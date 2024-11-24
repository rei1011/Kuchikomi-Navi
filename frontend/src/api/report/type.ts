import { ExtractGet, ExtractResponse } from "@/utils/type-utils";

export type Messages = ExtractResponse<ExtractGet<"/comparison_report">>;

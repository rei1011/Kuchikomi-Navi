"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import SearchSharpIcon from "@mui/icons-material/SearchSharp";
import { InputAdornment, TextField } from "@mui/material";
import { SubmitHandler, useForm } from "react-hook-form";
import { z } from "zod";

/**
 * バリデーション定義
 */
const schema = z.object({
  keyword: z.string(),
});
type SchemaType = z.infer<typeof schema>;

/**
 * props
 */
type SearchFieldType = {
  submit: (data: SchemaType) => void;
  className?: string;
};

/**
 * 検索バー
 */
export function SearchField(props: SearchFieldType) {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<SchemaType>({ resolver: zodResolver(schema) });
  const { submit, className } = props;
  const onSubmit: SubmitHandler<SchemaType> = (data) => submit(data);

  return (
    <form onSubmit={handleSubmit(onSubmit)} className={className}>
      <TextField
        {...register("keyword")}
        className="w-full h-2"
        variant="standard"
        InputProps={{
          sx: {
            borderRadius: 2,
            backgroundColor: "#EDEDED",
          },
          disableUnderline: true,
          startAdornment: (
            <InputAdornment position="start">
              <SearchSharpIcon />
            </InputAdornment>
          ),
        }}
      />
    </form>
  );
}

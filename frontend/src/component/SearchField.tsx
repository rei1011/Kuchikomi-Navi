"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import SearchSharpIcon from "@mui/icons-material/SearchSharp";
import { InputAdornment, TextField } from "@mui/material";
import { Controller, SubmitHandler, useForm } from "react-hook-form";
import { z } from "zod";

/**
 * バリデーション定義
 */
const schema = z.object({
  keyword: z.string().nullable(),
});
type SchemaType = z.infer<typeof schema>;

/**
 * props
 */
type SearchFieldType = {
  submit: (data: SchemaType["keyword"]) => void;
  defaultValue: string | null;
  className?: string;
};

/**
 * 検索バー
 */
export function SearchField(props: SearchFieldType) {
  const { submit, className, defaultValue } = props;
  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm<SchemaType>({
    resolver: zodResolver(schema),
    defaultValues: { keyword: defaultValue },
  });

  const onSubmit: SubmitHandler<SchemaType> = (data) => submit(data.keyword);

  return (
    <form onSubmit={handleSubmit(onSubmit)} className={className}>
      <Controller
        name="keyword"
        control={control}
        render={({ field }) => {
          return (
            <TextField
              {...field}
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
              inputProps={{ enterKeyHint: "search" }}
            />
          );
        }}
      ></Controller>
    </form>
  );
}

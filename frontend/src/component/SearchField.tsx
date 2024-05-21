"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import SearchIcon from "@mui/icons-material/Search";
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
  const { submit } = props;
  const onSubmit: SubmitHandler<SchemaType> = (data) => submit(data);

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <TextField
        {...register("keyword")}
        variant="outlined"
        InputProps={{
          startAdornment: (
            <InputAdornment position="start">
              <SearchIcon />
            </InputAdornment>
          ),
        }}
      />
    </form>
  );
}

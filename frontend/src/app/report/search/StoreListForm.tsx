"use client";

import { useReportContext } from "@/app/report-context";
import {
  RadioButtonGroup,
  RadioButtonOptions,
} from "@/component/RadioButtonGroup";
import Button from "@mui/material/Button";
import { useRouter } from "next/navigation";
import { useCallback } from "react";

type Props = {
  options: RadioButtonOptions;
};

export const StoreListForm = (props: Props) => {
  const { options } = props;
  const { setStore } = useReportContext();
  const router = useRouter();
  const onSubmit = useCallback(
    (e: React.FormEvent<HTMLFormElement>) => {
      e.preventDefault();
      router.push("/report/input");
    },
    [router]
  );

  return (
    <div className="p-4 w-full">
      <form onSubmit={onSubmit}>
        <RadioButtonGroup
          label="店舗を選択"
          options={options}
          onChange={(event) => {
            setStore(event.target.value);
          }}
        />
        <Button className="w-full" type="submit" variant="outlined">
          選択
        </Button>
      </form>
    </div>
  );
};

"use client";

import { useReportContext } from "@/app/report/rooms/[id]/report-context";
import {
  RadioButtonGroup,
  RadioButtonOptions,
} from "@/component/RadioButtonGroup";
import Button from "@mui/material/Button";
import { useRouter } from "next/navigation";
import { useCallback } from "react";

type Props = {
  options: RadioButtonOptions;
  roomId: string;
};

export const StoreListForm = (props: Props) => {
  const { options, roomId } = props;
  const { setStore, updateRoom } = useReportContext();
  const router = useRouter();
  const onSubmit = useCallback(
    async (e: React.FormEvent<HTMLFormElement>) => {
      e.preventDefault();
      await updateRoom();
      router.push(`/report/rooms/${roomId}/input`);
    },
    [roomId, router, updateRoom]
  );

  return (
    <div className="p-4 w-full">
      <form onSubmit={onSubmit}>
        <RadioButtonGroup
          label="店舗を選択"
          options={options}
          onChange={(event) => {
            setStore(event.target.value, options);
          }}
        />
        <Button className="w-full" type="submit" variant="outlined">
          選択
        </Button>
      </form>
    </div>
  );
};

"use client";

import {
  RadioButtonGroup,
  RadioButtonOptions,
} from "@/component/RadioButtonGroup";
import Button from "@mui/material/Button";
import { useRouter } from "next/navigation";
import { useCallback } from "react";
import { useReportContext } from "../report-context";

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
      router.push(`/rooms/${roomId}/input`);
    },
    [roomId, router, updateRoom]
  );

  return (
    <div className="p-4 w-full">
      <form onSubmit={onSubmit}>
        <div className="pb-16">
          <RadioButtonGroup
            label="店舗を選択"
            options={options}
            onChange={(event) => {
              setStore(event.target.value, options);
            }}
          />
        </div>
        <div className="fixed bottom-0 left-0 w-full p-4 bg-primary">
          <Button
            className="w-full bg-secondary border-secondary text-black"
            type="submit"
            variant="outlined"
            disableRipple
            disableTouchRipple
            focusRipple={false}
          >
            選択
          </Button>
        </div>
      </form>
    </div>
  );
};

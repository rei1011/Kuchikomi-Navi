"use client";

import { createRoom } from "@/api/rooms/api";
import AddCommentIcon from "@mui/icons-material/AddComment";
import Button from "@mui/material/Button";
import { useRouter } from "next/navigation";

export const StartChatButton = () => {
  const router = useRouter();
  return (
    <Button
      disableRipple
      size="small"
      color="inherit"
      className="w-full"
      onClick={async () => {
        const res = await createRoom(2);
        router.push(`/rooms/${res.id}/input`);
      }}
    >
      <div className="border-2 border-gray flex justify-center p-6 border-dashed rounded-xl w-full">
        <div className="flex gap-2 items-center">
          <AddCommentIcon />
          Start new chat
        </div>
      </div>
    </Button>
  );
};

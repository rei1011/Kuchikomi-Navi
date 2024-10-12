import { TextareaAutosize } from "@mui/material";

export const InputHowToCompareArea = () => {
  return (
    <div className="w-full">
      <TextareaAutosize minRows={4} className="w-full" />
    </div>
  );
};

import { TextareaAutosize } from "@mui/material";

type Props = {
  onChange: (e: React.ChangeEvent<HTMLTextAreaElement>) => void;
};

export const StickyInput = (props: Props) => {
  const { onChange } = props;
  return (
    <div className="bg-secondary p-2 rounded-t-2xl">
      <TextareaAutosize
        minRows={1}
        className="w-full p-4 bg-secondary outline-none text-black"
        placeholder="send message"
        onChange={onChange}
      />
    </div>
  );
};

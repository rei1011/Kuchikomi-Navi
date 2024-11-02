import ArrowUpwardIcon from "@mui/icons-material/ArrowUpward";
import { TextareaAutosize } from "@mui/material";

type Props = {
  onChange: (e: React.ChangeEvent<HTMLTextAreaElement>) => void;
  onSubmit: () => void;
};

export const StickyInput = (props: Props) => {
  const { onChange, onSubmit } = props;
  return (
    <div className="bg-secondary p-4 rounded-t-2xl flex justify-between items-end gap-4">
      <TextareaAutosize
        minRows={1}
        className="w-full bg-secondary outline-none text-black resize-none"
        placeholder="send message"
        onChange={onChange}
      />
      <button
        type="submit"
        className="bg-gray rounded-lg flex justify-center items-center p-2"
        style={{ height: 24, width: 24 }}
        onClick={onSubmit}
      >
        <ArrowUpwardIcon
          className="text-secondary"
          style={{ width: 16, height: 16 }}
        />
      </button>
    </div>
  );
};

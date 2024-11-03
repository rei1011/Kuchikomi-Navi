import ArrowUpwardIcon from "@mui/icons-material/ArrowUpward";
import { TextareaAutosize } from "@mui/material";

type Props = {
  onChange: (e: React.ChangeEvent<HTMLTextAreaElement>) => void;
  onSubmit: () => void;
  value: string;
};

export const StickyInput = (props: Props) => {
  const { onChange, onSubmit, value } = props;
  return (
    <div className="bg-secondary px-4 pt-4 pb-8 rounded-t-2xl flex justify-between items-end gap-4 sticky bottom-0">
      <TextareaAutosize
        value={value}
        minRows={1}
        maxRows={10}
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

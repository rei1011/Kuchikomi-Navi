import AddCommentIcon from "@mui/icons-material/AddComment";

export const StartChatButton = () => {
  return (
    <div className="border-2 border-gray flex justify-center p-6 border-dashed rounded-xl w-full">
      <div className="flex gap-2">
        <AddCommentIcon />
        Start new chat
      </div>
    </div>
  );
};

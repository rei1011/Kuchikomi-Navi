import MoreHorizIcon from "@mui/icons-material/MoreHoriz";

export const EditChatRoomButton = () => {
  return (
    <button
      onClick={(e) => {
        e.stopPropagation();
        console.log("hoge");
      }}
    >
      <MoreHorizIcon />
    </button>
  );
};

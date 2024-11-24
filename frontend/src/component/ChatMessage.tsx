type Props = {
  $role: "user" | "assistant";
  message: string;
};

export const ChatMessage = (props: Props) => {
  const { $role, message } = props;
  return (
    <div
      className={`flex w-full break-words ${$role === "user" ? "justify-end" : ""}`}
    >
      <div className="bg-secondary p-4 rounded-xl w-4/5">
        <div>{message}</div>
      </div>
    </div>
  );
};

type Props = {
  role: "user" | "assistant";
};

export const ChatMessage = (props: Props) => {
  const { role } = props;
  return (
    <div className={`flex w-full ${role === "user" ? "justify-end" : ""}`}>
      <div className="bg-primary p-4 rounded-xl w-4/5">
        <div>ChatMessage</div>
      </div>
    </div>
  );
};

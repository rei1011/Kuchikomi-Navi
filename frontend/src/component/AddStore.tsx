import AddBoxIcon from "@mui/icons-material/AddBox";

type Props = {
  selectedStore: string | undefined;
};

export const AddStore = (props: Props) => {
  const { selectedStore } = props;

  return (
    <div className="border-2 border-gray flex justify-center p-10 border-dashed rounded-xl">
      {selectedStore ?? <AddBoxIcon className="text-gray" />}
    </div>
  );
};

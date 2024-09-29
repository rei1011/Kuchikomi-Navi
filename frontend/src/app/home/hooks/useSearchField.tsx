import { useCallback, useState } from "react";

export const useSearchField = () => {
  const [searchFieldOpen, setSearchFieldOpen] = useState<boolean>(false);
  const toggleSearchField = useCallback(
    () => setSearchFieldOpen((prev) => !prev),
    []
  );

  return {
    searchFieldOpen,
    toggleSearchField,
  };
};

"use client";

import { useEffect, useState } from "react";

export function Comments() {
  const [data, setData] = useState<any[] | null>(null);

  useEffect(() => {
    fetch("http://localhost:3000/comments")
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        setData(data);
      });
  }, []);

  if (!data) return <div>Loading...</div>;

  return <ul>{JSON.stringify(data)}</ul>;
}

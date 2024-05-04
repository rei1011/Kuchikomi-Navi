async function getData() {
  const res = await fetch("http://web:3000/comments");
  // The return value is *not* serialized
  // You can return Date, Map, Set, etc.

  if (!res.ok) {
    // This will activate the closest `error.js` Error Boundary
    throw new Error("Failed to fetch data");
  }

  return res.json();
}

export async function ServerComments() {
  const data = await getData();

  return <main>{JSON.stringify(data)}</main>;
}

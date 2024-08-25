import "@testing-library/jest-dom";
import { convertStoreData } from "../domain";

describe("store domain", () => {
  test("convert store data", () => {
    console.log("test")
    const result = convertStoreData();
    expect(result).toStrictEqual({});
  });
});

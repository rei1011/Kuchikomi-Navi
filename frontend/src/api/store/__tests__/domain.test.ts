import "@testing-library/jest-dom";
import { convertStoreData } from "../domain";

describe("store domain", () => {
  test("convert store data", () => {
    console.log("hoge")
    const result = convertStoreData();
    expect(result).toStrictEqual({});
  });
});

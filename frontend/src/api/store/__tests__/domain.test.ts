import "@testing-library/jest-dom";
import { convertStoreData } from "../domain";

describe("store domain", () => {
  test("convert store data", () => {
    const result = convertStoreData();
    expect(result).toStrictEqual({});
  });
});

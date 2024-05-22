import { isBlank, stringToUrl } from "../string-utils";

describe("StringToUrl", () => {
  test.each`
    input                   | expected
    ${"https://google.com"} | ${new URL("https://google.com")}
    ${"hoge"}               | ${undefined}
    ${1}                    | ${undefined}
    ${null}                 | ${undefined}
    ${undefined}            | ${undefined}
  `("returns $expected when input is $input", ({ input, expected }) => {
    expect(stringToUrl(input)).toEqual(expected);
  });
});

describe("isBlank", () => {
  test.each`
    input        | expected
    ${""}        | ${true}
    ${null}      | ${true}
    ${undefined} | ${true}
  `("returns $expected when input is $input", ({ input, expected }) => {
    expect(isBlank(input)).toEqual(expected);
  });
});

import { stringToUrl } from "../string-utils";

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

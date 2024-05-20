/**
 * 文字列をURL型に変換
 * @param input
 * @returns
 */
export function stringToUrl(input?: string) {
  if (input == null) {
    return undefined;
  }

  let url;

  try {
    url = new URL(input);
  } catch (e) {
    console.error(e);
  }

  return url;
}

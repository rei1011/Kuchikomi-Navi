/**
 * 文字列をURL型に変換
 * @param input
 * @returns
 */
export function stringToUrl(input?: string) {
  if (isBlank(input)) {
    return undefined;
  }

  let url;

  try {
    url = new URL(input!);
  } catch (e) {
    console.error(e);
  }

  return url;
}

/**
 * 文字列のから判定を行う
 * @param input
 * @returns
 */
export function isBlank(input: string | undefined | null) {
  if (input == null || input == "") {
    return true;
  }

  return false;
}

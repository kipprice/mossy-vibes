export const trim = (text: string) => {
  const preWhitespaceRegex = /^\s*/
  const postWhitespaceRegex = /\s*$/
  return text.replace(preWhitespaceRegex, '').replace(postWhitespaceRegex, '')
}

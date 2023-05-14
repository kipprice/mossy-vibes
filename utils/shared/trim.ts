export const trim = (text: string) => {
  if (!text) { return text }
  const preWhitespaceRegex = /^\s*/
  const postWhitespaceRegex = /\s*$/
  return text.replace(preWhitespaceRegex, '').replace(postWhitespaceRegex, '')
}

export const exerciseFilenames = ['welcome', 'breathing-practice']

export const loadFile = async (filename: string) => {
  const resp = await fetch(`${process.env.HOSTING_URL}/models/${filename}.md`)
  return (await resp.text()).split(/\n/g)
}

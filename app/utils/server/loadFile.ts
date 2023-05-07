import fs from 'fs'
import path from 'path'

export const exerciseFilenames = ['welcome', 'breathing-practice']

export const loadFile = async (filename: string) => {
  const resp = await fetch(`${process.env.HOSTING_URL}/models/${filename}.md`)
  return (await resp.text()).split(/\n/g)
  // if (filename === 'welcome') {
  //   return welcomeFile.toString().split(/\n/g)
  // }
  // const f = await fs.open(
  //   path.join(__dirname, `../../app/models/${filename}.md`),
  //   'r'
  // )
  // const out = []
  // for await (const ln of f.readLines()) {
  //   out.push(ln)
  // }
  // await f.close()
  // return out
}

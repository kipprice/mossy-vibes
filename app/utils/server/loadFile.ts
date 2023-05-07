import fs from 'fs'
import path from 'path'

export const exerciseFilenames = ['welcome', 'breathing-practice']

export const exercises: Record<string, string[]> = {}

const seedFiles = () => {
  for (const k of exerciseFilenames) {
    exercises[k] = fs
      .readFileSync(path.join(__dirname, `../../app/models/${k}.md`))
      .toString()
      .split(/\n/g)
  }
}

export const loadFile = async (filename: string) => {
  return exercises[filename]
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

seedFiles()

import fs from 'fs/promises'
import path from 'path'

export const loadFile = async (filename: string) => {
  console.log(__dirname)
  const f = await fs.open(
    path.join(__dirname, `../../app/models/${filename}.md`),
    'r'
  )
  const out = []
  for await (const ln of f.readLines()) {
    out.push(ln)
  }
  await f.close()
  return out
}

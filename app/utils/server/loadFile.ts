import fs from 'fs/promises'
import path from 'path'

export const loadFile = async (filename: string) => {
  console.log(__dirname)
  const f = await fs.open(
    process.env.NODE_ENV === 'development'
      ? path.join(__dirname, `../../public/models/${filename}.md`)
      : `/models/${filename}.md`,
    'r'
  )
  const out = []
  for await (const ln of f.readLines()) {
    out.push(ln)
  }
  await f.close()
  return out
}

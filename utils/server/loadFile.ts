import fs from 'fs/promises'
import path from 'path'

export const exerciseFilenames = [
  'welcome',
  'breathing-practice',
  'benefits-of-meditation',
  'gratitude',
  'taking-a-moment',
  'waking-up',
  'what-is-mindfulness',
  'relaxation',
  'love'
]

export const loadFile = async (filename: string) => {
  const resp = await fetch(`${process.env.HOSTING_URL}/models/${filename}.md`)
  return (await resp.text()).split(/\n/g)
}

export const openFile = async (filename: string, ) => {
  const f = await fs.open(path.join(`models/exercises/${filename}.md`))
  const lines: string[] = [];
  for await (const ln of f.readLines()) {
    lines.push(ln)
  }
  await f.close()
  return lines
}
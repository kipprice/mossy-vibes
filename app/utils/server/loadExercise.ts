import type { ParsedExercise } from '~/_types'
import { loadFile } from './loadFile'
import { parseExerciseLine } from './parseExerciseLine'

export const loadExercise = async (filename: string) => {
  const lines = await loadFile(filename)
  const exercise: ParsedExercise = {
    id: filename,
    title: '',
    prompts: [],
  }

  for (const ln of lines) {
    parseExerciseLine(ln, exercise)
  }

  return exercise
}

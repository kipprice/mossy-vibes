import { ParsedExercise } from '../types'
import { loadFile, openFile } from './loadFile'
import { parseExerciseLine } from './parseExerciseLine'

export const loadExercise = async (filename: string) => {
  const lines = await openFile(filename)
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

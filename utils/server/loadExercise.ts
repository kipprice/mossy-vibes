import { ParsedExercise } from '../types'
import { clearTrailingLines } from './clearTrailingLines'
import { loadFile, openFile } from './loadFile'
import { parseExerciseLine } from './parseExerciseLine'

export const loadExercise = async (filename: string) => {
  const lines = await openFile(filename)
  const exercise: ParsedExercise = {
    id: filename,
    title: '',
    prompts: [],
    tags: [],
    author: ''
  }

  for (const ln of lines) {
    parseExerciseLine(ln, exercise)
  }

  clearTrailingLines(exercise)

  console.log(exercise)

  return exercise
}

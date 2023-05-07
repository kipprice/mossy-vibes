import type { ParsedExercise } from '~/_types'
import { loadExercise } from './loadExercise'

export const loadAllExercises = async (): Promise<ParsedExercise[]> => {
  const exerciseFilenames = ['welcome', 'breathing-practice']

  const exercisePromises = []
  for (const fn of exerciseFilenames) {
    exercisePromises.push(loadExercise(fn))
  }
  return await Promise.all(exercisePromises)
}

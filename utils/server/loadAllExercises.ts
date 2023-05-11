import { ParsedExercise } from '../types'
import { loadExercise } from './loadExercise'
import { exerciseFilenames } from './loadFile'

export const loadAllExercises = async (): Promise<ParsedExercise[]> => {
  const exercisePromises = []
  for (const fn of exerciseFilenames) {
    exercisePromises.push(loadExercise(fn))
  }
  return await Promise.all(exercisePromises)
}

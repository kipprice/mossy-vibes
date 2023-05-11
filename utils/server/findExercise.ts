import { loadAllExercises } from '../server/loadAllExercises'
import { loadExercise } from './loadExercise'

export const selectRandomExercise = async () => {
  const exercises = await loadAllExercises()

  // for now, this just random from the exercises we have
  const length = exercises.length
  return exercises[Math.floor(Math.random() * length)]
}

export const findExercise = async (exerciseId: string) => {
  const exercise = await loadExercise(exerciseId)
  return exercise || null
}

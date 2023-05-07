import { loadAllExercises } from '../server/loadAllExercises'

export const selectRandomExercise = async () => {
  const exercises = await loadAllExercises()

  // for now, this just random from the exercises we have
  const length = exercises.length
  return exercises[Math.floor(Math.random() * length)]
}

export const findExercise = async (exerciseId: string) => {
  const exercises = await loadAllExercises()

  for (const ex of exercises) {
    if (ex.id !== exerciseId) {
      continue
    }
    return ex
  }
  return null
}

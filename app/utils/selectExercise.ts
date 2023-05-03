import { exercises } from '~/data/exercises'

export const selectExercise = () => {
  // for now, this just random from the exercises we have
  const length = exercises.length
  return exercises[Math.floor(Math.random() * length)]
}

export const findExercise = (exerciseId: string) => {
  for (const ex of exercises) {
    if (ex.id !== exerciseId) {
      continue
    }
    return ex
  }
  return null
}

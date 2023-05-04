export type Exercise = {
  id: string
  title: string
  prompts: Prompt[]
}

export type ExerciseDetails = {
  id: string
  title: string
  lengthInSeconds: number
  isFavorite: boolean
  hasCompleted: boolean
}

export type Prompt = {
  content: string
  countInSec?: number
  countByBreath?: 'in' | 'hold' | 'out'
}

export type User = {
  readingSpeedInWpm: number
  completedExercises: string[]
  favoriteExercises: string[]
}

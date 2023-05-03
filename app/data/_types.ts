export type Exercise = {
  id: string
  title: string
  prompts: Prompt[]
}

export type Prompt = {
  content: string
  delayBeforeInMs?: number
  delayAfterInMs?: number
}

export type User = {
  readingSpeedInWpm: number
  completedExercises: string[]
  favoriteExercises: string[]
}

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
  prompts: Prompt[]
}

export type Prompt = {
  content: string
  countInSec?: number
  countByBreath?: 'in' | 'hold' | 'out'
}

export type UserData = {
  readingSpeedInWpm?: number
  inBreathInSeconds?: number
  holdBreathInSeconds?: number
  outBreathInSeconds?: number
  completedExercises?: string[]
  favoriteExercises?: string[]
}

export type ParsedExercise = {
  id: string
  title: string
  prompts: ParsedPrompt[]
}

export type ParsedPrompt = {
  content: string
  minBreathParts?: number
  toggleBreathAnimation?: boolean
}

export type ClientExercise = Omit<ParsedExercise, 'prompts'> & {
  prompts: ClientPrompt[]
}

export type Timing = 'in' | 'hold' | 'out' | 'full' | 'wpm'
export type ClientPrompt = Pick<ParsedPrompt, 'content'> & {
  lengthInSeconds: number
}
export const BREATH_CYCLE: Timing[] = ['in', 'hold', 'out']

export const BREATH_PARTS_TO_WHOLE = 3
export const DEFAULT_BREATH_IN_IN_SECONDS = 4
export const DEFAULT_BREATH_HOLD_IN_SECONDS = 7
export const DEFAULT_BREATH_OUT_IN_SECONDS = 8
export const DEFAULT_FULL_BREATH_IN_SECONDS =
  DEFAULT_BREATH_IN_IN_SECONDS +
  DEFAULT_BREATH_HOLD_IN_SECONDS +
  DEFAULT_BREATH_OUT_IN_SECONDS
export const DEFAULT_BREAK_IN_SECONDS = 2

export const DEFAULT_READING_SPEED_IN_WPM = 200

export const USER_DATA_KEY = 'user-data'

export const DEFAULT_USER_DATA: UserData = {
  readingSpeedInWpm: DEFAULT_READING_SPEED_IN_WPM,
  inBreathInSeconds: DEFAULT_BREATH_IN_IN_SECONDS,
  outBreathInSeconds: DEFAULT_BREATH_OUT_IN_SECONDS,
  holdBreathInSeconds: DEFAULT_BREATH_HOLD_IN_SECONDS,
}

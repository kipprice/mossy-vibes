import type { ParsedExercise, ParsedPrompt, UserData } from '../../_types'
import { DEFAULT_BREAK_IN_SECONDS } from '../../_types'
import {
  DEFAULT_BREATH_HOLD_IN_SECONDS,
  DEFAULT_BREATH_IN_IN_SECONDS,
  DEFAULT_BREATH_OUT_IN_SECONDS,
  DEFAULT_READING_SPEED_IN_WPM,
} from '../../_types'
import { BREATH_PARTS_TO_WHOLE } from '../../_types'
import { ceilToInterval } from './ceilToInterval'
import { splitWords } from './splitWords'

export const getExerciseCount = (
  exercise: ParsedExercise,
  userData?: UserData
) => {
  let breathIdx = -1
  let length = 0

  for (const prompt of exercise.prompts) {
    if (prompt.toggleBreathAnimation) {
      if (breathIdx === -1) {
        breathIdx = 0
      } else {
        breathIdx = -1
      }
      continue
    }

    const { lengthInSeconds, nextBreathIdx } = getPromptCount(
      prompt,
      breathIdx,
      userData
    )
    breathIdx = nextBreathIdx
    length += lengthInSeconds
  }

  return length
}

/**
 * determines how long, in seconds, a particular prompt should last
 *
 * @param   prompt          The prompt to measure
 * @param   lastBreathIdx   The breath type preceding this prompt
 * @param   userData        What preferences the user has set around reading
 *                          speed and the breath pattern they are following
 *
 * @returns The number of seconds this prompt will take
 */
export const getPromptCount = (
  prompt: ParsedPrompt,
  lastBreathIdx = -1,
  userData: UserData = {
    readingSpeedInWpm: DEFAULT_READING_SPEED_IN_WPM,
    inBreathInSeconds: DEFAULT_BREATH_IN_IN_SECONDS,
    holdBreathInSeconds: DEFAULT_BREATH_HOLD_IN_SECONDS,
    outBreathInSeconds: DEFAULT_BREATH_OUT_IN_SECONDS,
  }
) => {
  // if this a prompt to toggle animation, return no length and no additional
  // breaths
  if (!prompt.minBreathParts) {
    const nextBreathIdx = lastBreathIdx === -1 ? 0 : -1
    return { lengthInSeconds: 0, nextBreathIdx: nextBreathIdx }
  }

  // start by calculating the wpm length
  const wpmLength = getWpmCount(prompt.content, userData.readingSpeedInWpm)
  if (lastBreathIdx === -1) {
    return {
      lengthInSeconds: wpmLength + DEFAULT_BREAK_IN_SECONDS,
      nextBreathIdx: lastBreathIdx,
    }
  }

  // calculate the min breaths for each piece
  let runningIdx = lastBreathIdx
  let minLength = 0

  for (let bIdx = 0; bIdx < prompt.minBreathParts; bIdx += 1) {
    runningIdx += 1

    const breathType = getBreathTypeFromIdx(runningIdx)
    minLength += getBreathCountFromType(breathType, userData) || 0
  }

  if (wpmLength > minLength) {
    const { length, additionalBreathCounts } = normalizeWpmCount(
      wpmLength,
      minLength,
      runningIdx,
      userData
    )
    return {
      lengthInSeconds: length,
      nextBreathIdx: runningIdx + additionalBreathCounts,
    }
  } else {
    return {
      lengthInSeconds: minLength,
      nextBreathIdx: runningIdx,
    }
  }
}

/**
 * determine how long a set of words will take at the specified reading speed
 *
 * @param   content             The string to break apart into words
 * @param   readingSpeedInWpm   The speed at which these words will be read
 *
 * @returns The length of time, in seconds, that these words will be read.
 */
export const getWpmCount = (
  content: string,
  readingSpeedInWpm: number = DEFAULT_READING_SPEED_IN_WPM
) => {
  const wordsPerSecond = readingSpeedInWpm / 60
  const words = splitWords(content)
  return Math.ceil(words.length / wordsPerSecond)
}

/**
 * ensure that the words per minute count is rounded to the next breath piece
 *
 * @param wpmLength
 * @param minLength
 * @param currentBreathIdx
 * @param userData
 * @returns
 */
export const normalizeWpmCount = (
  wpmLength: number,
  minLength: number,
  currentBreathIdx: number,
  userData?: UserData
) => {
  if (wpmLength <= minLength) {
    return { length: minLength, additionalBreathCounts: 0 }
  }

  if (currentBreathIdx === -1) {
    return { length: wpmLength, additionalBreathCounts: 0 }
  }

  let curLength = minLength
  let runningIdx = currentBreathIdx

  while (wpmLength > curLength) {
    runningIdx += 1
    const breathLength = getBreathCountFromType(
      getBreathTypeFromIdx(runningIdx),
      userData
    )
    curLength += breathLength
  }

  return {
    length: curLength,
    additionalBreathCounts: runningIdx - currentBreathIdx,
  }
}

/**
 * determine what breath type we are on, based on the global index of the count
 * @param   breathIdx  The current breath count we are on
 * @returns
 */
export const getBreathTypeFromIdx = (breathIdx: number) => {
  switch (breathIdx % BREATH_PARTS_TO_WHOLE) {
    case 1:
      return 'in'
    case 2:
      return 'hold'
    default:
      return 'out'
  }
}

export const getBreathCountFromType = (
  breathType: 'in' | 'out' | 'hold',
  breathProps?: Pick<
    UserData,
    'holdBreathInSeconds' | 'inBreathInSeconds' | 'outBreathInSeconds'
  >
) => {
  switch (breathType) {
    case 'in':
      return breathProps?.inBreathInSeconds || DEFAULT_BREATH_IN_IN_SECONDS
    case 'hold':
      return breathProps?.holdBreathInSeconds || DEFAULT_BREATH_HOLD_IN_SECONDS
    case 'out':
      return breathProps?.outBreathInSeconds || DEFAULT_BREATH_OUT_IN_SECONDS
    default:
      return breathProps?.inBreathInSeconds || DEFAULT_BREATH_HOLD_IN_SECONDS
  }
}

export const getFullBreathLength = (
  breathProps?: Pick<
    UserData,
    'holdBreathInSeconds' | 'inBreathInSeconds' | 'outBreathInSeconds'
  >
) => {
  return (
    getBreathCountFromType('in', breathProps) +
    getBreathCountFromType('hold', breathProps) +
    getBreathCountFromType('out', breathProps)
  )
}

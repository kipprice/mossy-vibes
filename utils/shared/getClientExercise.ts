import type { ClientExercise, ParsedExercise, UserData } from '~/_types'
import { getPromptCount } from '../shared/getCounts'

export const getClientExercise = (
  exercise: ParsedExercise,
  userData: UserData
) => {
  const out: ClientExercise = {
    id: exercise.id,
    title: exercise.title,
    prompts: [],
  }

  let breathIdx = -1
  for (const p of exercise.prompts) {
    const { lengthInSeconds, nextBreathIdx } = getPromptCount(
      p,
      breathIdx,
      userData
    )
    breathIdx = nextBreathIdx
    out.prompts.push({
      content: p.content,
      lengthInSeconds,
    })
  }

  return out
}

import { BREATH_PARTS_TO_WHOLE } from '~/_types'
import type { ParsedExercise } from '~/_types'
import { trim } from '../shared'

export const parseExerciseLine = (ln: string, exercise: ParsedExercise) => {
  // parse out a title
  if (ln[0] === '#') {
    exercise.title = trim(ln.replace(/#/g, ''))
    return exercise
  }

  if (trim(ln) === '') {
    exercise.prompts.push({ content: '', toggleBreathAnimation: true })
    return exercise
  }

  const breathPieces = ln.split(/\//g)

  // lines without a break are assigned
  if (breathPieces.length === 1) {
    exercise.prompts.push({
      content: trim(ln),
      minBreathParts: BREATH_PARTS_TO_WHOLE,
    })
  } else {
    const lastPcAddition =
      breathPieces.length % BREATH_PARTS_TO_WHOLE
        ? BREATH_PARTS_TO_WHOLE - (breathPieces.length % BREATH_PARTS_TO_WHOLE)
        : 0

    breathPieces.forEach((pc, pcIdx) => {
      exercise.prompts.push({
        content: trim(pc),
        minBreathParts:
          pcIdx === breathPieces.length - 1 ? 1 + lastPcAddition : 1,
      })
    })
  }

  return exercise
}

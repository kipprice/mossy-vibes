import { trim } from '../shared'
import { BREATH_PARTS_TO_WHOLE, ParsedExercise } from '../types'

export const parseExerciseLine = (ln: string, exercise: ParsedExercise) => {
  // parse out a title
  if (ln[0] === '#') {
    exercise.title = trim(ln.replace(/#/g, ''))
    return exercise
  }

  // parse out meta
  if (ln[0] === '[') {
    const match = /\[_meta:(.*?)\]:-\s*"(.*?)"/.exec(ln);
    if (match) {
      const [_, key, val] = match
      switch (key) {
        case 'author':
          exercise.author = val;
          break;
        case 'tags':
          exercise.tags = exercise.tags.concat(val.split(',').map((pc) => trim(pc)))
          break
      }
    }
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

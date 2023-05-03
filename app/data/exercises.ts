import type { Exercise } from './_types'

export const test: Exercise = {
  id: 'test-exercise',
  title: 'This is an example exercise',
  prompts: [
    { content: 'This is a test prompt', delayAfterInMs: 2 * 1000 },
    { content: 'That was a two second pause', delayAfterInMs: 5 * 1000 },
    { content: 'Take a breath in...', delayAfterInMs: 8 * 1000 },
    { content: '...and breathe out', delayAfterInMs: 10 * 1000 },
    { content: 'In...', delayAfterInMs: 8 * 1000 },
    { content: '...and out', delayAfterInMs: 10 * 1000 },
    { content: "That's it for today! Congratulations on meditating." },
  ],
}

export const exercises = [test]

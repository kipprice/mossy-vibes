import type { Exercise } from './_types'

export const test: Exercise = {
  id: 'test-exercise',
  title: 'Welcome Exercise',
  prompts: [
    { content: 'Welcome to Levitate!', countByBreath: 'in' },
    {
      content: 'We want to help you build up your meditation practice',
      countByBreath: 'hold',
    },
    {
      content: "Let's start by bringing attention to your breathing",
      countByBreath: 'out',
    },
    { content: 'Take a breath in...', countByBreath: 'in' },
    { content: '...hold it...', countByBreath: 'hold' },
    { content: '...and breathe out', countByBreath: 'out' },
    { content: 'In...', countByBreath: 'in' },
    { content: '...hold...', countByBreath: 'hold' },
    { content: '...and out', countByBreath: 'out' },
    { content: "That's it for today! Congratulations on meditating." },
  ],
}

export const exercises = [test]

import type { Exercise } from './_types'

export const welcome: Exercise = {
  id: 'test-exercise',
  title: 'Welcome',
  prompts: [
    { content: 'Welcome to Mossy Vibes!', countByBreath: 'in' },
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

export const breathing: Exercise = {
  id: 'breathing-exercise',
  title: 'Practice your Breathing',
  prompts: [
    { content: 'One of the most important elements', countByBreath: 'in' },
    { content: 'when it comes to meditation', countByBreath: 'hold' },
    { content: 'is breath control', countByBreath: 'out' },
    { content: 'By focusing on', countByBreath: 'in' },
    { content: 'your breathing', countByBreath: 'hold' },
    { content: 'you help train your mind to focus', countByBreath: 'out' },
    { content: 'If you took only one', countByBreath: 'in' },
    { content: 'focused breath', countByBreath: 'hold' },
    { content: 'every day', countByBreath: 'out' },
    { content: 'you will start', countByBreath: 'in' },
    { content: 'to find it easier to focus', countByBreath: 'hold' },
    { content: 'on anything you are doing', countByBreath: 'out' },
    { content: 'Take a breath in...', countByBreath: 'in' },
    { content: '...hold it...', countByBreath: 'hold' },
    { content: '...and breathe out', countByBreath: 'out' },
    { content: 'In...', countByBreath: 'in' },
    { content: '...hold...', countByBreath: 'hold' },
    { content: '...and out', countByBreath: 'out' },
    { content: 'One more, in...', countByBreath: 'in' },
    { content: '...hold...', countByBreath: 'hold' },
    { content: '...and out.', countByBreath: 'out' },
    { content: "You're done! Enjoy your focus", countByBreath: 'in' },
  ],
}

export const exercises = [welcome, breathing]

import type { Prompt } from '~/data/_types'

export const getPromptCount = (prompt: Prompt) => {
  if (prompt.countInSec) {
    return prompt.countInSec
  }

  switch (prompt.countByBreath) {
    case 'in':
      return 4
    case 'hold':
      return 7
    case 'out':
      return 8
    default:
      return 4
  }
}

export const getPromptCountInMs = (prompt: Prompt) => {
  return getPromptCount(prompt) * 1000
}

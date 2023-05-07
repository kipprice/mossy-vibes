import { AnimatePresence } from 'framer-motion'
import React, { useEffect } from 'react'
import type { ClientExercise, UserData } from '../../../_types'
import { WordScroller } from './WordScroller'

export type PromptScrollerProps = {
  exercise: ClientExercise
  currentPromptIdx: number
  onNextPrompt: () => void
  onComplete: () => void
  userData: UserData
}

const MILLISECONDS_PER_SECOND = 1000

export const PromptScroller: React.FC<PromptScrollerProps> = ({
  exercise,
  currentPromptIdx,
  onNextPrompt,
  onComplete,
  userData,
}) => {
  const prompt = exercise.prompts[currentPromptIdx]

  useEffect(() => {
    if (!prompt) {
      return
    }
    if (currentPromptIdx === exercise.prompts.length) {
      return
    }

    const tmId = setTimeout(() => {
      if (currentPromptIdx === exercise.prompts.length - 1) {
        onComplete()
      } else {
        onNextPrompt()
      }
    }, prompt.lengthInSeconds * MILLISECONDS_PER_SECOND)

    return () => clearTimeout(tmId)
  }, [
    prompt,
    onNextPrompt,
    exercise.prompts.length,
    currentPromptIdx,
    onComplete,
  ])

  return (
    <AnimatePresence mode="wait">
      <WordScroller
        key={`prompt-${
          prompt.lengthInSeconds ? currentPromptIdx : currentPromptIdx - 1
        }`}
        prompt={prompt}
        userData={userData}
      />
    </AnimatePresence>
  )
}

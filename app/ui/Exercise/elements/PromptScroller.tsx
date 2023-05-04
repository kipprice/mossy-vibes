import { motion } from 'framer-motion'
import React, { useEffect } from 'react'
import type { Exercise } from '../../../data/_types'
import { getPromptCountInMs } from '../../../utils/getCounts'
import { PromptDisplay } from './Prompt'

export type PromptScrollerProps = {
  exercise: Exercise
  currentPromptIdx: number
  onNextPrompt: () => void
}

export const PromptScroller: React.FC<PromptScrollerProps> = ({
  exercise,
  currentPromptIdx,
  onNextPrompt,
}) => {
  const prompt = exercise.prompts[currentPromptIdx]

  useEffect(() => {
    if (!prompt) {
      return
    }
    if (exercise.prompts.length === currentPromptIdx - 1) {
      return
    }

    const tmId = setTimeout(() => {
      onNextPrompt()
    }, getPromptCountInMs(prompt))

    return () => clearTimeout(tmId)
  }, [prompt, onNextPrompt, exercise?.prompts.length, currentPromptIdx])

  return (
    <motion.div layout="position">
      {currentPromptIdx <= 1 ? (
        <motion.div className="text-sm"> </motion.div>
      ) : null}

      {currentPromptIdx < 1 ? (
        <motion.div className="text-md"> </motion.div>
      ) : null}

      {exercise.prompts.map((p, pIdx) => (
        <PromptDisplay
          key={`prompt-${pIdx}`}
          prompt={p}
          idx={pIdx}
          selectedIdx={currentPromptIdx}
        />
      ))}
    </motion.div>
  )
}

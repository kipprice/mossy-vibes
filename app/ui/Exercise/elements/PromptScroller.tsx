import { motion } from 'framer-motion'
import React, { useEffect } from 'react'
import type { ClientExercise } from '../../../_types'
import { WordScroller } from './WordScroller'

export type PromptScrollerProps = {
  exercise: ClientExercise
  currentPromptIdx: number
  onNextPrompt: () => void
}

const MILLISECONDS_PER_SECOND = 1000

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
    }, prompt.lengthInSeconds * MILLISECONDS_PER_SECOND)

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

      {exercise.prompts.map((p, pIdx) => {
        return pIdx === currentPromptIdx ? (
          <WordScroller key={`prompt-${pIdx}`} prompt={p} />
        ) : null
        // <PromptDisplay
        //   key={`prompt-${pIdx}`}
        //   prompt={p}
        //   idx={pIdx}
        //   selectedIdx={currentPromptIdx}
        // />
      })}
    </motion.div>
  )
}

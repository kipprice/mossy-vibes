import { motion } from 'framer-motion'
import React from 'react'
import type { ClientPrompt } from '../../../_types'

export type PromptDisplayProps = {
  idx: number
  prompt: ClientPrompt
  selectedIdx: number
}

export const PromptDisplay: React.FC<PromptDisplayProps> = ({
  idx,
  selectedIdx,
  prompt,
}) => {
  const isSelected = idx === selectedIdx
  const isPrevious = idx === selectedIdx - 1
  const isGrandPrevious = idx === selectedIdx - 2
  const isHidden = !isSelected && !isPrevious && !isGrandPrevious

  if (isHidden) {
    return <motion.div>{null}</motion.div>
  }

  return (
    <motion.div
      className={`text-center ${getFontSize({
        isSelected,
        isGrandPrevious,
        isPrevious,
      })}`}
      initial={{
        opacity: 1,
      }}
      animate={{
        opacity: 0.2,
      }}
      transition={{
        duration: prompt.lengthInSeconds / 4,
        delay: (prompt.lengthInSeconds * 3) / 4,
      }}
    >
      {isHidden ? null : prompt.content}
    </motion.div>
  )
}

const getFontSize = ({
  isSelected,
  isPrevious,
  isGrandPrevious,
}: Record<string, boolean>) => {
  if (isSelected) {
    return 'text-xl'
  }
  if (isPrevious) {
    return 'text-md'
  }
  return 'text-sm'
}

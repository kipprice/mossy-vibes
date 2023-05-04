import { motion } from 'framer-motion'
import React from 'react'
import { Prompt } from '../data/_types'
import { getPromptCount } from '../utils/getCounts'

export type PromptDisplayProps = {
  idx: number
  prompt: Prompt
  selectedIdx: number
  nextDelay?: number
}

export const PromptDisplay: React.FC<PromptDisplayProps> = ({
  idx,
  selectedIdx,
  prompt,
  nextDelay = 2,
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
        duration: getPromptCount(prompt) / 4,
        delay: (getPromptCount(prompt) * 3) / 4,
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

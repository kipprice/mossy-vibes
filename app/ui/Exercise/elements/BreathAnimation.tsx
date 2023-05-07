import { motion } from 'framer-motion'
import React from 'react'
import type { UserData } from '~/_types'
import { getAnimationTiming, getFullBreathLength } from '../../../utils/shared'

export type BreathAnimationProps = {
  userData: UserData
}

export const BreathAnimation: React.FC<BreathAnimationProps> = ({
  userData,
}) => {
  const variants = {
    breathe: {
      transform: [
        `scale(0.9) rotate(0deg)`,
        `scale(1.4) rotate(120deg)`,
        `scale(1.4) rotate(240deg)`,
        `scale(0.9) rotate(360deg)`,
      ],
    },
  }
  return (
    <motion.div className="w-full flex items-center justify-center p-16">
      <motion.div className="bg-green-light rounded-full w-25vw h-25vw relative">
        <motion.div
          className={`absolute border-4 border-dotted border-green-light w-full h-full rounded-full`}
          variants={variants}
          animate="breathe"
          transition={{
            duration: getFullBreathLength(userData),
            times: getAnimationTiming(userData),
            ease: 'linear',
            repeat: Infinity,
          }}
        ></motion.div>
      </motion.div>
    </motion.div>
  )
}

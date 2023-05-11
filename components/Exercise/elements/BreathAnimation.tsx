import { motion } from 'framer-motion'
import React from 'react'
import { getAnimationTiming, getFullBreathLength } from '../../../utils/shared'
import { UserData } from '../../../utils/types'

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
      <motion.div className="bg-green-light rounded-full w-25vh h-25vh relative">
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

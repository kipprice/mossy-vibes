import { motion } from 'framer-motion'
import React from 'react'
import { getUserData, useAsyncMemo } from '../../../utils/client'

export type BreathAnimationProps = {}

export const BreathAnimation: React.FC<BreathAnimationProps> = ({}) => {
  const userData = useAsyncMemo(getUserData, [])

  return (
    <motion.div className="w-full flex items-center justify-center p-16">
      <motion.div className="bg-green-light rounded-full w-25vw h-25vw relative">
        <motion.div
          className={`absolute border-2 border-dotted border-green-light ${
            userData?.holdBreathInSeconds === 4
              ? 'animate-breath-quick'
              : userData?.holdBreathInSeconds === 10
              ? 'animate-breath-long'
              : 'animate-breathe-standard'
          } w-full h-full rounded-full`}
        ></motion.div>
      </motion.div>
    </motion.div>
  )
}

import { motion } from 'framer-motion'
import { get } from 'idb-keyval'
import React, { useEffect, useState } from 'react'
import type { ClientPrompt } from '../../../_types'
import { DEFAULT_USER_DATA, USER_DATA_KEY } from '../../../_types'
import { useAsyncMemo } from '../../../utils/client'
import { splitWords } from '../../../utils/shared'

export type WordScrollerProps = {
  prompt: ClientPrompt
}

export const WordScroller: React.FC<WordScrollerProps> = ({ prompt }) => {
  const [activeWordIdx, setActiveWordIdx] = useState(0)

  const words = splitWords(prompt.content)

  const secondsPerWord = useAsyncMemo(async () => {
    const userData = (await get(USER_DATA_KEY)) || DEFAULT_USER_DATA
    return 1 / (userData.readingSpeedInWpm / 60)
  }, [])

  useEffect(() => {
    if (!secondsPerWord) {
      return
    }
    if (activeWordIdx >= words.length) {
      return
    }

    const tmId = setTimeout(() => {
      setActiveWordIdx(activeWordIdx + 1)
    }, (words[activeWordIdx] !== '¶' ? secondsPerWord : secondsPerWord * 3) * 1000)

    return () => clearTimeout(tmId)
  }, [secondsPerWord, activeWordIdx, words])

  return (
    <motion.div layout className="px-8 w-full max-w-3xl text-center">
      {words.map((w, wIdx) => (
        <motion.div
          key={`word-${wIdx}`}
          className={`${w ? 'mr-2' : ''} text-2xl inline-block ${
            w === '¶' ? 'w-full' : ''
          }`}
          initial={{ opacity: 0 }}
          animate={{
            opacity:
              activeWordIdx === wIdx ||
              (wIdx === words.length - 1 && activeWordIdx >= words.length)
                ? 1
                : activeWordIdx > wIdx
                ? 0.5
                : 0.1,
          }}
          transition={{ duration: secondsPerWord }}
        >
          {w === '¶' ? '' : w}
        </motion.div>
      ))}
    </motion.div>
  )
}

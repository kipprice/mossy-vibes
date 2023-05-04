import React, { useCallback } from 'react'
import type { Exercise } from '../../data/_types'
import { BreathAnimation } from './elements/BreathAnimation'
import { PromptScroller } from './elements/PromptScroller'

export type ExerciseActiveProps = {
  exercise: Exercise
  currentPromptIdx: number
  setCurrentPromptIdx: React.Dispatch<React.SetStateAction<number>>
}

export const ExerciseActive: React.FC<ExerciseActiveProps> = ({
  exercise,
  currentPromptIdx,
  setCurrentPromptIdx,
}) => {
  const onNext = useCallback(() => {
    setCurrentPromptIdx((idx) => idx + 1)
  }, [setCurrentPromptIdx])

  return (
    <div className="w-full h-full flex flex-col justify-center">
      <div className="text-sm text-center font-light p-2  bg-black bg-opacity-20">
        {exercise.title}
      </div>
      <div className="flex-grow" />
      <PromptScroller
        exercise={exercise}
        onNextPrompt={onNext}
        currentPromptIdx={currentPromptIdx}
      />

      <BreathAnimation />
      <div className="flex-grow" />
    </div>
  )
}

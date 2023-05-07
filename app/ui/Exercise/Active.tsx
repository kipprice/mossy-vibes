import React, { useCallback, useState } from 'react'
import type { ClientExercise } from '../../_types'
import { LogFooter } from '../shared/LogFooter'
import { PageHeader } from '../shared/PageHeader'
import { BreathAnimation } from './elements/BreathAnimation'
import { PromptScroller } from './elements/PromptScroller'

export type ExerciseActiveProps = {
  exercise: ClientExercise
  currentPromptIdx: number
  setCurrentPromptIdx: React.Dispatch<React.SetStateAction<number>>
}

export const ExerciseActive: React.FC<ExerciseActiveProps> = ({
  exercise,
  currentPromptIdx,
  setCurrentPromptIdx,
}) => {
  const [isBreathAnimationOn, setIsBreathAnimationOn] = useState(false)

  const onNext = useCallback(() => {
    setCurrentPromptIdx(currentPromptIdx + 1)
    if (exercise.prompts[currentPromptIdx + 1]?.lengthInSeconds === 0) {
      setIsBreathAnimationOn(!isBreathAnimationOn)
    }
  }, [
    setCurrentPromptIdx,
    currentPromptIdx,
    exercise.prompts,
    isBreathAnimationOn,
  ])

  return (
    <div className="w-full h-full flex flex-col justify-center">
      <PageHeader title={exercise.title} />
      <div className="flex-grow" />
      <PromptScroller
        exercise={exercise}
        onNextPrompt={onNext}
        currentPromptIdx={currentPromptIdx}
      />

      {isBreathAnimationOn ? <BreathAnimation /> : null}
      <div className="flex-grow" />
      <LogFooter />
    </div>
  )
}

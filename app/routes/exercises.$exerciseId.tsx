import { useLoaderData } from '@remix-run/react'
import React, { useState } from 'react'
import type { Exercise } from '../data/_types'
import { ExerciseActive, ExerciseEnd, ExerciseStart } from '../ui/Exercise'
import { findExercise, selectRandomExercise } from '../utils/selectExercise'

export type ExercisePageProps = {}

export const loader = ({ params }: any) => {
  const { exerciseId } = params
  return {
    exercise:
      exerciseId !== '*' ? findExercise(exerciseId) : selectRandomExercise(),
  } as ExercisePageProps
}

export const ExercisePage: React.FC<ExercisePageProps> = () => {
  const { exercise } = useLoaderData<{ exercise: Exercise }>()

  const [isStarted, setIsStarted] = useState(false)
  const [currentPromptIdx, setCurrentPromptIdx] = useState(0)

  const prompt = exercise.prompts[currentPromptIdx]

  if (!isStarted) {
    return (
      <ExerciseStart exercise={exercise} onStart={() => setIsStarted(true)} />
    )
  }

  if (!prompt) {
    return <ExerciseEnd exercise={exercise} />
  }

  return (
    <ExerciseActive
      exercise={exercise}
      currentPromptIdx={currentPromptIdx}
      setCurrentPromptIdx={setCurrentPromptIdx}
    />
  )
}

export default ExercisePage

import { useLoaderData } from '@remix-run/react'
import React, { useState } from 'react'
import type { ClientExercise, ParsedExercise } from '../_types'
import { ExerciseActive, ExerciseEnd, ExerciseStart } from '../ui/Exercise'
import { getUserData, useAsyncMemo } from '../utils/client'
import { findExercise, selectRandomExercise } from '../utils/server'
import { getClientExercise } from '../utils/shared'

export type ExercisePageProps = {
  exercise: ParsedExercise
}

export const loader = async ({ params }: any) => {
  const { exerciseId } = params
  return {
    exercise:
      exerciseId !== '*'
        ? await findExercise(exerciseId)
        : await selectRandomExercise(),
  } as ExercisePageProps
}

export const ExercisePage: React.FC<ExercisePageProps> = () => {
  const { exercise } = useLoaderData<{ exercise: ClientExercise }>()

  const clientExercise = useAsyncMemo(async () => {
    const userData = await getUserData()
    return getClientExercise(exercise, userData)
  }, [exercise])

  const [isStarted, setIsStarted] = useState(false)
  const [currentPromptIdx, setCurrentPromptIdx] = useState(0)

  const prompt = exercise.prompts[currentPromptIdx]

  if (!clientExercise) {
    return null
  }

  if (!isStarted) {
    return (
      <ExerciseStart
        exercise={clientExercise}
        onStart={() => setIsStarted(true)}
      />
    )
  }

  if (!prompt) {
    return <ExerciseEnd exercise={clientExercise} />
  }

  return (
    <ExerciseActive
      exercise={clientExercise}
      currentPromptIdx={currentPromptIdx}
      setCurrentPromptIdx={setCurrentPromptIdx}
    />
  )
}

export default ExercisePage

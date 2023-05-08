import { useLoaderData } from '@remix-run/react'
import React, { useState } from 'react'
import type { ClientExercise, ParsedExercise } from '../_types'
import { ExerciseActive, ExerciseStart } from '../ui/Exercise'
import { getUserData, useAsyncMemo } from '../utils/client'
import { preventSleep } from '../utils/client/noSleep'
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

  const { clientExercise, userData } = useAsyncMemo(async () => {
    const userData = await getUserData()
    return { userData, clientExercise: getClientExercise(exercise, userData) }
  }, [exercise]) || { clientExercise: null, userData: null }

  const [isStarted, setIsStarted] = useState(false)
  const [currentPromptIdx, setCurrentPromptIdx] = useState(0)

  if (!clientExercise) {
    return null
  }

  if (!isStarted) {
    return (
      <ExerciseStart
        exercise={clientExercise}
        onStart={() => {
          setIsStarted(true)
          preventSleep()
        }}
      />
    )
  }

  return (
    <ExerciseActive
      userData={userData}
      exercise={clientExercise}
      currentPromptIdx={currentPromptIdx}
      setCurrentPromptIdx={setCurrentPromptIdx}
    />
  )
}

export default ExercisePage

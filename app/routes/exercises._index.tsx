import { useLoaderData, useNavigate } from '@remix-run/react'
import { get } from 'idb-keyval'
import React, { useEffect } from 'react'
import type { ExerciseDetails } from '~/_types'
import { DEFAULT_USER_DATA, USER_DATA_KEY } from '~/_types'
import { Button } from '../ui'
import { ExerciseLine } from '../ui/Exercises/ExerciseLine'
import { PageHeader } from '../ui/shared/PageHeader'
import { loadAllExercises } from '../utils/server/loadAllExercises'
import { getExerciseCount } from '../utils/shared'

export type ExercisesPageProps = {
  exercises: ExerciseDetails[]
}

export const loader = async ({ params }: any) => {
  const exercises = await loadAllExercises()

  return {
    exercises: exercises.map((ex) => ({
      id: ex.id,
      title: ex.title,
      isFavorite: false,
      hasCompleted: false,
      lengthInSeconds: getExerciseCount(ex),
      prompts: ex.prompts,
    })),
  } as ExercisesPageProps
}

export const ExercisesPage: React.FC = () => {
  const { exercises } = useLoaderData<ExercisesPageProps>()

  useEffect(() => {
    ;(async () => {
      const userData = (await get(USER_DATA_KEY)) || DEFAULT_USER_DATA
      for (const ex of exercises) {
        ex.lengthInSeconds = getExerciseCount(ex, userData)
      }
    })()
  }, [exercises])

  const navigate = useNavigate()

  return (
    <>
      <PageHeader title="All Exercises" />
      <div className="flex flex-col h-[calc(100%-48px)] p-8 gap-4 mt-12">
        {exercises.map((ex) => (
          <ExerciseLine key={`exercise-${ex.id}`} exerciseDetails={ex} />
        ))}

        <div className="flex-grow" />
        <div className="col-span-4 w-full mx-4">
          <Button onClick={() => navigate('/exercises/*')}>
            Choose for Me
          </Button>
        </div>
      </div>
    </>
  )
}

export default ExercisesPage

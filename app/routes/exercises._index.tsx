import { useLoaderData, useNavigate } from '@remix-run/react'
import React, { useEffect, useState } from 'react'
import type { ExerciseDetails } from '~/_types'
import { Button } from '../ui'
import { ExerciseLine } from '../ui/Exercises/ExerciseLine'
import { FilterForm } from '../ui/Exercises/FilterForm'
import { PageHeader } from '../ui/shared/PageHeader'
import { getUserData } from '../utils/client'
import { allowSleep } from '../utils/client/noSleep'
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
  const [filterFn, setFilterFn] = useState<(v: ExerciseDetails) => boolean>(
    () => () => true
  )

  useEffect(() => {
    allowSleep()
  }, [])

  useEffect(() => {
    ;(async () => {
      const userData = await getUserData()
      for (const ex of exercises) {
        ex.lengthInSeconds = getExerciseCount(ex, userData)
        ex.isFavorite = userData.favoriteExercises.indexOf(ex.id) !== -1
      }
    })()
  }, [exercises])

  const navigate = useNavigate()

  const filteredExercises = exercises.filter(filterFn)

  return (
    <>
      <PageHeader title="All Exercises" />
      <div className="flex flex-col h-[calc(100%-48px)] p-8 gap-4 mt-12">
        <FilterForm setFilterFn={setFilterFn} />
        <div className="flex flex-col gap-4 overflow-y-auto flex-grow">
          {filteredExercises.map((ex) => (
            <ExerciseLine key={`exercise-${ex.id}`} exerciseDetails={ex} />
          ))}
          {filteredExercises.length === 0 ? (
            <div className="italic font-light text-center opacity-70 text-lg">
              (No exercises match your current filters)
            </div>
          ) : null}
        </div>

        <div className="col-span-4 w-full">
          <Button onClick={() => navigate('/exercises/*')}>
            Choose for Me
          </Button>
        </div>
      </div>
    </>
  )
}

export default ExercisesPage

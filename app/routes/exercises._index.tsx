import { useLoaderData, useNavigate } from '@remix-run/react'
import React from 'react'
import type { ExerciseDetails } from '../data/_types'
import { exercises } from '../data/exercises'
import { Button } from '../ui'
import { ExerciseLine } from '../ui/Exercises/ExerciseLine'
import { PageHeader } from '../ui/shared/PageHeader'
import { getPromptCount } from '../utils/getCounts'

export type ExercisesPageProps = {
  exercises: ExerciseDetails[]
}

export const loader = ({ params }: any) => {
  return {
    exercises: exercises.map((ex) => ({
      id: ex.id,
      title: ex.title,
      lengthInSeconds: ex.prompts.reduce(
        (prev, cur) => (prev += getPromptCount(cur)),
        0
      ),
      isFavorite: false,
      hasCompleted: false,
    })),
  } as ExercisesPageProps
}

export const ExercisesPage: React.FC = () => {
  const { exercises } = useLoaderData<ExercisesPageProps>()

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

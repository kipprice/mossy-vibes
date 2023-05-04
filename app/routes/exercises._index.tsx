import { useLoaderData, useNavigate } from '@remix-run/react'
import React from 'react'
import type { ExerciseDetails } from '../data/_types'
import { exercises } from '../data/exercises'
import { Button } from '../ui'
import { ExerciseLine } from '../ui/Exercises/ExerciseLine'
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
    <div className="grid grid-cols-[max-content_1fr_max-content_max-content] gap-4 p-8">
      <h1 className="text-2xl col-span-4">All Exercises</h1>
      {exercises.map((ex) => (
        <ExerciseLine key={`exercise-${ex.id}`} exerciseDetails={ex} />
      ))}
      <div className="col-span-4">
        <Button onClick={() => navigate('/exercises/*')}>Select for Me</Button>
      </div>
    </div>
  )
}

export default ExercisesPage

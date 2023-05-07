import { useNavigate } from '@remix-run/react'
import React from 'react'
import type { ClientExercise } from '../../_types'
import { Button } from '../shared/Button'
import { LogFooter } from '../shared/LogFooter'
import { PageHeader } from '../shared/PageHeader'

export type ExerciseEndProps = {
  exercise: ClientExercise
}

export const ExerciseEnd: React.FC<ExerciseEndProps> = ({ exercise }) => {
  const navigate = useNavigate()

  return (
    <>
      <PageHeader title={exercise.title} />
      <div className="w-full h-full flex flex-col justify-center px-4 py-8">
        <div className="text-2xl text-center mb-8">All Done!</div>
        <Button onClick={() => navigate('/exercises')}>
          Back to Exercises
        </Button>
      </div>
      <LogFooter />
    </>
  )
}

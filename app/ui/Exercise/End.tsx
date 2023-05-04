import { useNavigate } from '@remix-run/react'
import React from 'react'
import type { Exercise } from '../../data/_types'
import { Button } from '../shared/Button'

export type ExerciseEndProps = {
  exercise: Exercise
}

export const ExerciseEnd: React.FC<ExerciseEndProps> = ({ exercise }) => {
  const navigate = useNavigate()

  return (
    <div className="w-full h-full flex flex-col justify-center px-4 py-8">
      <div className="text-sm text-center mb-8">{exercise.title}</div>
      <div className="text-2xl text-center mb-8">All Done!</div>
      <Button onClick={() => navigate('/')}>Back to Home</Button>
    </div>
  )
}

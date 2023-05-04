import React from 'react'
import type { Exercise } from '../../data/_types'
import { Button } from '../shared/Button'

export type ExerciseStartProps = {
  exercise: Exercise
  onStart: () => void
}

export const ExerciseStart: React.FC<ExerciseStartProps> = ({
  onStart,
  exercise,
}) => {
  return (
    <div className="w-full h-full flex flex-col justify-center px-4 py-8">
      <div className="text-3xl text-center mb-8">{exercise.title}</div>
      <Button onClick={onStart}>Begin</Button>
    </div>
  )
}

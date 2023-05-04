import React from 'react'
import type { Exercise } from '../../data/_types'
import { Button } from '../shared/Button'
import { LogFooter } from '../shared/LogFooter'
import { PageHeader } from '../shared/PageHeader'

export type ExerciseStartProps = {
  exercise: Exercise
  onStart: () => void
}

export const ExerciseStart: React.FC<ExerciseStartProps> = ({
  onStart,
  exercise,
}) => {
  return (
    <>
      <PageHeader title={exercise.title} />
      <div className="w-full h-full flex flex-col justify-center px-8 py-8">
        <Button onClick={onStart}>Begin</Button>
        <LogFooter />
      </div>
    </>
  )
}

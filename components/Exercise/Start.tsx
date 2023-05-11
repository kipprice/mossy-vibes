import React from 'react'
import { Button } from '../shared/Button'
import { LogFooter } from '../shared/LogFooter'
import { PageHeader } from '../shared/PageHeader'
import { ClientExercise } from '../../utils/types'

export type ExerciseStartProps = {
  exercise: ClientExercise
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
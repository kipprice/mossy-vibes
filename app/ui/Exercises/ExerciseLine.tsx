import { useNavigate } from '@remix-run/react'
import React from 'react'
import type { ExerciseDetails } from '../../data/_types'

export type ExerciseLineProps = {
  exerciseDetails: ExerciseDetails
}

export const ExerciseLine: React.FC<ExerciseLineProps> = ({
  exerciseDetails,
}) => {
  const navigate = useNavigate()

  return (
    <>
      <button onClick={() => null}>
        {exerciseDetails.isFavorite ? (
          <img
            className="w-8"
            src="/img/star.png"
            alt="selected as a favorite exercise"
          />
        ) : (
          <img
            className="w-8"
            src="/img/empty-star.png"
            alt="not selected as a favorite exercise"
          />
        )}
      </button>
      <div
        className={`${
          exerciseDetails.hasCompleted ? 'opacity-50' : 'opacity-100'
        } text-xl`}
      >
        {exerciseDetails.title}
      </div>
      <div className="font-light text-lg">
        {Math.ceil(exerciseDetails.lengthInSeconds / 60)} minute(s)
      </div>
      <button onClick={() => navigate(`/exercises/${exerciseDetails.id}`)}>
        →
      </button>
    </>
  )
}

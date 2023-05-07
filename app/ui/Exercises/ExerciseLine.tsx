import { useNavigate } from '@remix-run/react'
import React from 'react'
import type { ExerciseDetails } from '../../_types'
import { Icon } from '../shared'

export type ExerciseLineProps = {
  exerciseDetails: ExerciseDetails
}

export const ExerciseLine: React.FC<ExerciseLineProps> = ({
  exerciseDetails,
}) => {
  const navigate = useNavigate()

  const lengthInMinutes = Math.ceil(exerciseDetails.lengthInSeconds / 60)

  return (
    <div
      onClick={() => navigate(`/exercises/${exerciseDetails.id}`)}
      className="text-left flex flex-row w-full gap-4 "
    >
      <button
        onClick={() => null}
        className="w-9 flex justify-center items-center"
      >
        {exerciseDetails.isFavorite ? (
          <Icon
            iconFileName="star_fill"
            className="text-orange-light bg-transparent w-8 h-8"
          />
        ) : (
          <Icon
            iconFileName="star_outline"
            className="text-orange-light bg-transparent w-8 h-8 hover:fill-[#FFAA5A66] transition-all"
          />
        )}
      </button>
      <button
        className="text-left flex flex-row w-full gap-4 hover:bg-off-white hover:bg-opacity-10 rounded-lg p-4 transition-all"
        onClick={() => navigate(`/exercises/${exerciseDetails.id}`)}
      >
        <div className={'flex flex-col md:flex-row gap-1 md:gap-4 flex-grow'}>
          <div
            className={`${
              exerciseDetails.hasCompleted ? 'opacity-50' : 'opacity-100'
            } text-xl flex-grow`}
          >
            {exerciseDetails.title}
          </div>
          <div className="font-light text-lg">
            {lengthInMinutes} minute{lengthInMinutes === 1 ? '' : 's'}
          </div>
        </div>
        <div className="w-9">
          <Icon
            iconFileName="right_arrow"
            className="text-off-white-light bg-transparent w-8 h-8"
          />
        </div>
      </button>
    </div>
  )
}

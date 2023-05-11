import React, { useCallback, useEffect, useState } from 'react'
import { getUserData, setUserData, useAsyncMemo, useNavigate } from '../../utils/client'
import { Icon } from '../shared'
import { ExerciseDetails, UserData } from '../../utils/types'

export type ExerciseLineProps = {
  exerciseDetails: ExerciseDetails
}

export const ExerciseLine: React.FC<ExerciseLineProps> = ({
  exerciseDetails,
}) => {
  const navigate = useNavigate()

  const userData = useAsyncMemo<UserData>(getUserData, [])

  const [localUser, setLocalUser] = useState<UserData>()

  useEffect(() => {
    if (!userData) {
      return
    }
    setLocalUser(userData)
  }, [userData])

  const onChangeFavorite = useCallback(() => {
    const updatedData = {
      ...localUser,
      favoriteExercises: [...(localUser?.favoriteExercises || [])],
    } as UserData
    const searchIdx =
      updatedData.favoriteExercises?.indexOf(exerciseDetails.id) ?? -1

    if (searchIdx === -1) {
      updatedData.favoriteExercises?.push(exerciseDetails.id)
    } else {
      updatedData.favoriteExercises?.splice(searchIdx, 1)
    }
    setLocalUser(updatedData)
    setUserData(updatedData)
  }, [exerciseDetails.id, localUser])

  const isFavorite = localUser?.favoriteExercises
    ? localUser?.favoriteExercises?.indexOf(exerciseDetails.id) !== -1
    : false
  const lengthInMinutes = Math.ceil(exerciseDetails.lengthInSeconds / 60)

  return (
    <div className="text-left flex flex-row w-full gap-4 ">
      <button
        onClick={onChangeFavorite}
        className="w-9 flex justify-center items-center"
      >
        {isFavorite ? (
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

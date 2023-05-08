import React, { useCallback, useEffect, useState } from 'react'
import type { UserData } from '../../_types'
import { getUserData, setUserData, useAsyncMemo } from '../../utils/client'
import { FormButton } from '../shared'

export type ReadingSpeedInputProps = {}

export const BreathInput: React.FC<ReadingSpeedInputProps> = ({}) => {
  const userData = useAsyncMemo<UserData>(getUserData, [])

  const [localUser, setLocalUser] = useState<UserData>()

  useEffect(() => {
    if (!userData) {
      return
    }
    setLocalUser(userData)
  }, [userData])

  const onUpdate = useCallback(
    async (data: Partial<UserData>) => {
      const updatedData = { ...localUser, ...data }
      setLocalUser(updatedData as UserData)
      await setUserData(updatedData as UserData)
    },
    [localUser]
  )

  return (
    <div className="flex flex-col">
      <label className="text-xl font-light text-center">
        What breathing speed do you prefer?
      </label>
      <FormButton
        onClick={() =>
          onUpdate({
            inBreathInSeconds: 3,
            holdBreathInSeconds: 2,
            outBreathInSeconds: 3,
          })
        }
        isSelected={localUser?.holdBreathInSeconds === 10}
      >
        Quick (3 • 2 • 3)
      </FormButton>

      <div className="flex flex-col lg:flex-row mt-2 gap-2 text-2xl items-center w-full">
        <FormButton
          onClick={() =>
            onUpdate({
              inBreathInSeconds: 4,
              holdBreathInSeconds: 4,
              outBreathInSeconds: 4,
            })
          }
          isSelected={localUser?.holdBreathInSeconds === 4}
        >
          Calm (4 • 4 • 4)
        </FormButton>

        <FormButton
          onClick={() =>
            onUpdate({
              inBreathInSeconds: 4,
              holdBreathInSeconds: 7,
              outBreathInSeconds: 8,
            })
          }
          isSelected={localUser?.holdBreathInSeconds === 7}
        >
          Relaxing (4 • 7 • 8)
        </FormButton>
      </div>
    </div>
  )
}

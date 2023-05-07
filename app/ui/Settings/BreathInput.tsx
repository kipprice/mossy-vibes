import React, { useCallback, useEffect, useState } from 'react'
import type { UserData } from '../../_types'
import { getUserData, setUserData, useAsyncMemo } from '../../utils/client'
import { FormButton } from './FormButton'

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
    async (data: UserData) => {
      const updatedData = { ...userData, ...data }
      setLocalUser(updatedData)
      await setUserData(updatedData)
    },
    [userData]
  )

  return (
    <>
      <label className="text-xl font-light">
        What breathing speed do you prefer?
      </label>
      <div className="flex flex-row mt-2 gap-2 text-2xl items-center">
        <div className="flex gap-4">
          <FormButton
            onClick={() =>
              onUpdate({
                holdBreathInSeconds: 4,
                inBreathInSeconds: 4,
                outBreathInSeconds: 4,
              })
            }
            isSelected={localUser?.holdBreathInSeconds === 4}
          >
            Shorter (4 • 4 • 4)
          </FormButton>

          <FormButton
            onClick={() =>
              onUpdate({
                holdBreathInSeconds: 7,
                inBreathInSeconds: 4,
                outBreathInSeconds: 8,
              })
            }
            isSelected={localUser?.holdBreathInSeconds === 7}
          >
            Standard (4 • 7 • 8)
          </FormButton>

          <FormButton
            onClick={() =>
              onUpdate({
                holdBreathInSeconds: 10,
                inBreathInSeconds: 8,
                outBreathInSeconds: 12,
              })
            }
            isSelected={localUser?.holdBreathInSeconds === 10}
          >
            Longer (8 • 10 • 12)
          </FormButton>
        </div>
      </div>
    </>
  )
}

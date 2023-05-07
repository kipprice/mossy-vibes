import React, { useCallback, useEffect, useState } from 'react'
import type { UserData } from '../../_types'
import { getUserData, setUserData, useAsyncMemo } from '../../utils/client'
import { FormButton } from './FormButton'

export type ReadingSpeedInputProps = {}

export const ReadingSpeedInput: React.FC<ReadingSpeedInputProps> = ({}) => {
  const userData = useAsyncMemo<UserData>(getUserData, [])

  const [localUser, setLocalUser] = useState<UserData>()

  useEffect(() => {
    if (!userData) {
      return
    }
    setLocalUser(userData)
  }, [userData])

  const onUpdate = useCallback(
    async (readingSpeedInWpm: number) => {
      const updatedData = { ...userData, readingSpeedInWpm }
      setLocalUser(updatedData)
      await setUserData(updatedData)
    },
    [userData]
  )

  return (
    <>
      <label className="text-xl font-light">
        What reading speed do you prefer?
      </label>
      <div className="flex flex-row mt-2 gap-2 text-2xl items-center">
        <div className="flex gap-4">
          <FormButton
            onClick={() => onUpdate(75)}
            isSelected={localUser?.readingSpeedInWpm === 75}
          >
            Leisurely
          </FormButton>

          <FormButton
            onClick={() => onUpdate(150)}
            isSelected={localUser?.readingSpeedInWpm === 150}
          >
            Standard
          </FormButton>

          <FormButton
            onClick={() => onUpdate(200)}
            isSelected={localUser?.readingSpeedInWpm === 200}
          >
            Quick
          </FormButton>

          <FormButton
            onClick={() => onUpdate(250)}
            isSelected={localUser?.readingSpeedInWpm === 250}
          >
            Speedy
          </FormButton>
        </div>
      </div>
    </>
  )
}

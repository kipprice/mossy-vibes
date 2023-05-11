import React, { useCallback, useEffect, useState } from 'react'
import { getUserData, setUserData, useAsyncMemo } from '../../utils/client'
import { FormButton } from '../shared'
import { UserData } from '../../utils/types'

export type ReadingSpeedInputProps = {
  localUser: UserData
  setLocalUser: (ud: Partial<UserData>) => void
}

export const BreathInput: React.FC<ReadingSpeedInputProps> = ({ localUser, setLocalUser }) => {

  return (
    <div className="flex flex-col">
      <label className="text-xl font-light text-center">
        What breathing speed do you prefer?
      </label>

      <div className="flex flex-col lg:flex-row mt-2 gap-2 text-2xl items-center w-full lg:justify-center">
        <FormButton
          onClick={() =>
            setLocalUser({
              inBreathInSeconds: 3,
              holdBreathInSeconds: 2,
              outBreathInSeconds: 3,
            })
          }
          isSelected={localUser?.holdBreathInSeconds === 2}
        >
          Quick (3 • 2 • 3)
        </FormButton>
        <FormButton
          onClick={() =>
            setLocalUser({
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
            setLocalUser({
              inBreathInSeconds: 4,
              holdBreathInSeconds: 7,
              outBreathInSeconds: 8,
            })
          }
          isSelected={localUser?.holdBreathInSeconds === 7}
        >
          Relaxed (4 • 7 • 8)
        </FormButton>
      </div>
    </div>
  )
}

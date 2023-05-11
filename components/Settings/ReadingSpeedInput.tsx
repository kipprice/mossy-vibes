import React, { useCallback, useEffect, useState } from 'react'
import { getUserData, setUserData, useAsyncMemo } from '../../utils/client'
import { FormButton } from '../shared'
import { UserData } from '../../utils/types'

export type ReadingSpeedInputProps = {
  localUser: UserData
  setLocalUser: (ud: Partial<UserData>) => void
}

export const ReadingSpeedInput: React.FC<ReadingSpeedInputProps> = ({ setLocalUser, localUser}) => {

  return (
    <div className="flex flex-col">
      <label className="text-xl font-light text-center">
        What reading speed do you prefer?
      </label>
      <div className="flex flex-col lg:flex-row mt-2 gap-2 text-2xl items-center lg:justify-center">
        <FormButton
          onClick={() => setLocalUser({ readingSpeedInWpm: 75 })}
          isSelected={localUser?.readingSpeedInWpm === 75}
        >
          Leisurely
        </FormButton>

        <FormButton
          onClick={() => setLocalUser({ readingSpeedInWpm: 150 })}
          isSelected={localUser?.readingSpeedInWpm === 150}
        >
          Standard
        </FormButton>

        <FormButton
          onClick={() => setLocalUser({ readingSpeedInWpm: 200 })}
          isSelected={localUser?.readingSpeedInWpm === 200}
        >
          Quick
        </FormButton>

        <FormButton
          onClick={() => setLocalUser({ readingSpeedInWpm: 250 })}
          isSelected={localUser?.readingSpeedInWpm === 250}
        >
          Speedy
        </FormButton>
      </div>
    </div>
  )
}

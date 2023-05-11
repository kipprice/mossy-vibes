import React, { useCallback, useEffect, useState } from 'react'
import { BreathInput } from './BreathInput'
import { ReadingSpeedInput } from './ReadingSpeedInput'
import { DEFAULT_USER_DATA, UserData } from '../../utils/types'
import { setUserData, useAsyncMemo, useUserData } from '../../utils/client'

export type SettingsFormProps = {}

export const SettingsForm: React.FC<SettingsFormProps> = ({}) => {
  const [localUser, setLocalUser] = useState<UserData>(DEFAULT_USER_DATA)

  const userData = useUserData('settings')

  useEffect(() => {
    if (!userData) {
      return
    }
    setLocalUser(userData)
  }, [userData])

  const onSetLocalUser = useCallback(async (data: Partial<UserData>) => {
    const updatedData = { ...localUser, ...data }
    setLocalUser(updatedData as UserData)
    await setUserData(updatedData as UserData)
  }, [localUser])

  return (
    <form className="pt-20 w-full" onSubmit={(e) => e.preventDefault()}>
      <ReadingSpeedInput localUser={localUser} setLocalUser={onSetLocalUser} />
      <div className="mt-8" />
      <BreathInput localUser={localUser} setLocalUser={onSetLocalUser}/>
    </form>
  )
}

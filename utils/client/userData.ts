import { get, set } from 'idb-keyval'
import { useEffect, useState } from 'react'
import { DEFAULT_USER_DATA, USER_DATA_KEY, UserData } from '../types'

export const getUserData = async (): Promise<Required<UserData>> => {
  return {
    ...DEFAULT_USER_DATA,
    ...((await get(USER_DATA_KEY)) || {}),
  }
}

export const setUserData = async (ud: UserData) => {
  return await set(USER_DATA_KEY, ud)
}

export const useUserData = (pageName: string) => {
  const [userData, setUserData] = useState(DEFAULT_USER_DATA)

  useEffect(() => {
    (async () => {
      const ud = await getUserData()
      setUserData(ud)
    })()
  }, [pageName])

  return userData
}
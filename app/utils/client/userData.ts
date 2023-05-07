import { get, set } from 'idb-keyval'
import type { UserData } from '~/_types'
import { DEFAULT_USER_DATA, USER_DATA_KEY } from '~/_types'

export const getUserData = async (): Promise<Required<UserData>> => {
  return {
    ...DEFAULT_USER_DATA,
    ...((await get(USER_DATA_KEY)) || {}),
  }
}

export const setUserData = async (ud: UserData) => {
  return await set(USER_DATA_KEY, ud)
}

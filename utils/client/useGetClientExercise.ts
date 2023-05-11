import { getClientExercise } from "../shared"
import { DEFAULT_USER_DATA, ParsedExercise, UserData } from "../types"
import { useAsyncMemo } from "./useAsyncMemo"
import { getUserData } from "./userData"

export const useGetClientExercise = (exercise: ParsedExercise) => {
    const userData = useAsyncMemo<UserData>(getUserData, [])
    if (!exercise) { return }
    return getClientExercise(exercise, userData || DEFAULT_USER_DATA)
}
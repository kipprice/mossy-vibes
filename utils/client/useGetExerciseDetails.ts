import { getExerciseCount } from "../shared";
import { DEFAULT_USER_DATA, ExerciseDetails, ParsedExercise, UserData } from "../types";
import { useAsyncMemo } from "./useAsyncMemo";
import { getUserData } from "./userData";

export const useGetExerciseDetails = (exercise: ParsedExercise) => {
    const userData = useAsyncMemo<UserData>(getUserData, [])
    if (!exercise) { return }
    return getExerciseDetails(exercise, userData || DEFAULT_USER_DATA)
}

export const useGetAllExerciseDetails = (exercises: ParsedExercise[]) => {
    const userData = useAsyncMemo<UserData>(getUserData, [])

    if (!exercises) { return [] }
    return exercises.map((exercise) => {
        if (!exercise) { return exercise }
        return getExerciseDetails(exercise, userData || DEFAULT_USER_DATA)
    })
}

const getExerciseDetails = (exercise: ParsedExercise, userData: UserData) => {
    return {
        id: exercise.id,
        title: exercise.title,
        prompts: exercise.prompts,
        author: exercise.author,
        tags: exercise.tags,
        hasCompleted: userData.completedExercises.indexOf(exercise.id) !== -1,
        isFavorite: userData.favoriteExercises.indexOf(exercise.id) !== -1,
        lengthInSeconds: getExerciseCount(exercise, userData),
    } as ExerciseDetails
}
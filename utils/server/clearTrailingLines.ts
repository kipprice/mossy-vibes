import { ParsedExercise } from "../types";

export const clearTrailingLines = (exercise: ParsedExercise) => {
    while (exercise.prompts[exercise.prompts.length - 1].toggleBreathAnimation) {
        exercise.prompts.splice(exercise.prompts.length - 1)
    }
    return exercise
}
import { useState } from "react"
import { preventSleep, useGetClientExercise, useUserData } from "../../utils/client"
import { ParsedExercise } from "../../utils/types"
import { ExerciseStart } from "./Start"
import { ExerciseActive } from "./Active"

export const ExercisePage: React.FC<{ exercise: ParsedExercise }> = ({ exercise }) => {
    const userData = useUserData(exercise.id)
    const clientExercise = useGetClientExercise(exercise)
  
    const [isStarted, setIsStarted] = useState(false)
    const [currentPromptIdx, setCurrentPromptIdx] = useState(0)
  
    if (!clientExercise) {
      return null
    }
  
    if (!isStarted) {
      return (
        <ExerciseStart
          exercise={clientExercise}
          onStart={() => {
            setIsStarted(true)
            preventSleep()
          }}
        />
      )
    }
  
    return (
      <ExerciseActive
        userData={userData}
        exercise={clientExercise}
        currentPromptIdx={currentPromptIdx}
        setCurrentPromptIdx={setCurrentPromptIdx}
      />
    )
  }
"use client"
import { exerciseFilenames, loadAllExercises, loadExercise } from "../../utils/server"
import { GetStaticPropsContext } from "next"
import { ParsedExercise } from "../../utils/types"
import { getUserData, preventSleep, useAsyncMemo, useUserData } from "../../utils/client"
import { useGetClientExercise } from "../../utils/client/useGetClientExercise"
import { useState } from "react"
import { ExerciseActive, ExerciseStart } from "../../components"


export const getStaticPaths = async () => {
    return {
      paths: exerciseFilenames.map((fname) => ({ params: { exerciseId: fname }})),
      fallback: false
    }
  }
  
  export const getStaticProps = async ({ params }: GetStaticPropsContext) => {
    const exerciseId = (params as any).exerciseId

    const exercise = await loadExercise(exerciseId)

    return {
        props: {
            exercise
        }
    }
  }

export const Page: React.FC<{ exercise: ParsedExercise }> = ({ exercise }) => {
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

export default Page
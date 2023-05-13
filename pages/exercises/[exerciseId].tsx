"use client"
import { GetStaticPropsContext } from "next"
import { ExercisePage } from "../../components"
import { exerciseFilenames, loadExercise } from "../../utils/server"
import { ParsedExercise } from "../../utils/types"


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

export const Exercise: React.FC<{ exercise: ParsedExercise }> = ({ exercise }) => {
  return <ExercisePage exercise={exercise} />
}

export default Exercise
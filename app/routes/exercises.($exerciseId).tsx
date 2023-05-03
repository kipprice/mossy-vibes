import { useLoaderData, useNavigate } from '@remix-run/react'
import React, { useEffect, useState } from 'react'
import { Exercise } from '../data/_types'
import { BreathAnimation } from '../ui/BreathAnimation'
import { findExercise, selectExercise } from '../utils/selectExercise'

export type ExercisePageProps = {}

export const loader = ({ params }: any) => {
  const { exerciseId } = params
  return {
    exercise: exerciseId ? findExercise(exerciseId) : selectExercise(),
  } as ExercisePageProps
}

export const ExercisePage: React.FC<ExercisePageProps> = () => {
  const { exercise } = useLoaderData<{ exercise: Exercise }>()

  const [isStarted, setIsStarted] = useState(false)
  const [currentPromptIdx, setCurrentPromptIdx] = useState(0)

  const navigate = useNavigate()

  const prompt = exercise.prompts[currentPromptIdx]

  useEffect(() => {
    if (!isStarted) {
      return
    }
    if (!prompt) {
      return
    }

    const tmId = setTimeout(() => {
      setCurrentPromptIdx((idx) => idx + 1)
    }, prompt.delayAfterInMs)

    return () => clearTimeout(tmId)
  }, [prompt, isStarted])

  if (!isStarted) {
    return (
      <div className="w-screen h-screen bg-Pine_green bg-opacity-70 text-white flex flex-col justify-center p-4">
        <div className="text-2xl text-center mb-8">{exercise.title}</div>
        <button
          className="bg-white text-Pine_green text-2xl rounded-full py-4"
          onClick={() => setIsStarted(true)}
        >
          Begin
        </button>
      </div>
    )
  }

  if (!prompt) {
    return (
      <div className="w-screen h-screen bg-Pine_green bg-opacity-70 text-white flex flex-col justify-center p-4">
        <div className="text-sm text-center mb-8">{exercise.title}</div>
        <div className="text-2xl text-center">All Done!</div>
        <button
          className="bg-white text-Pine_green text-2xl rounded-full py-4"
          onClick={() => navigate('/')}
        >
          Back to Home
        </button>
      </div>
    )
  }

  return (
    <div className="w-screen h-screen bg-Pine_green bg-opacity-70 text-white flex flex-col justify-center">
      <div className="text-sm text-center">{exercise.title}</div>
      <div className="flex-grow" />
      {exercise.prompts.map((p, pIdx) =>
        pIdx === currentPromptIdx - 1 ? (
          <div
            key={`prompt_${pIdx}`}
            className="text-lg text-center opacity-30"
          >
            {p.content}
          </div>
        ) : null
      )}
      <div
        key={`prompt_${currentPromptIdx}`}
        className={`text-xl text-center animate-[fade_${
          prompt.delayAfterInMs || 8000 / 1000
        }s_ease-out_forwards]`}
      >
        {prompt?.content}
      </div>

      <BreathAnimation />
      <div className="flex-grow" />
    </div>
  )
}

export default ExercisePage

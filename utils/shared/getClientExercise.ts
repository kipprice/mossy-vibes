import { getExerciseCount, getPromptCount } from "../shared/getCounts";
import { ClientExercise, ParsedExercise, UserData } from "../types";

export const getClientExercise = (
  exercise: ParsedExercise,
  userData: UserData
) => {
  const out: ClientExercise = {
    id: exercise.id,
    title: exercise.title,
    prompts: [],
    tags: exercise.tags,
    author: exercise.author,
    lengthInMinutes: Math.ceil(getExerciseCount(exercise, userData) / 60),
  };

  let breathIdx = -1;
  for (const p of exercise.prompts) {
    const { lengthInSeconds, nextBreathIdx } = getPromptCount(
      p,
      breathIdx,
      userData
    );
    breathIdx = nextBreathIdx;
    out.prompts.push({
      content: p.content,
      lengthInSeconds,
    });
  }

  return out;
};

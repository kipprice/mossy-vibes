import React from "react";
import { Button } from "../shared/Button";
import { LogFooter } from "../shared/LogFooter";
import { PageHeader } from "../shared/PageHeader";
import { ClientExercise } from "../../utils/types";

export type ExerciseStartProps = {
  exercise: ClientExercise;
  onStart: () => void;
};

export const ExerciseStart: React.FC<ExerciseStartProps> = ({
  onStart,
  exercise,
}) => {
  return (
    <>
      <PageHeader title={exercise.title} />
      <div className="w-full h-full flex flex-col justify-center px-8 py-8">
        <div className="flex gap-3 flex-col items-center text-off-white">
          <div className="flex items-center gap-2">
            <div className="text-md font-light">Written by</div>
            <div className="text-lg">{exercise.author}</div>
          </div>

          <div className="text-3xl font-light pb-2">
            {exercise.lengthInMinutes} minute
            {exercise.lengthInMinutes === 1 ? "" : "s"}
          </div>

          <div className="flex gap-2">
            {exercise.tags.map((t) => (
              <div
                key={`tag-${t}`}
                className="text-xl px-2 font-light rounded-full bg-off-white bg-opacity-10"
              >
                #{t}
              </div>
            ))}
          </div>
        </div>

        <div className="flex-grow" />
        <Button onClick={onStart}>Begin</Button>
        <div className="flex-grow-2" />
        <LogFooter />
      </div>
    </>
  );
};

import { AnimatePresence, motion } from "framer-motion";
import React, { useCallback, useEffect, useState } from "react";
import { allowSleep, preventSleep } from "../../utils/client/noSleep";
import { Button, FormButton } from "../shared";
import { LogFooter } from "../shared/LogFooter";
import { PageHeader } from "../shared/PageHeader";
import { BreathAnimation } from "./elements/BreathAnimation";
import { PromptScroller } from "./elements/PromptScroller";
import { useNavigate } from "../../utils/client";
import { ClientExercise, UserData } from "../../utils/types";

export type ExerciseActiveProps = {
  exercise: ClientExercise;
  currentPromptIdx: number;
  setCurrentPromptIdx: React.Dispatch<React.SetStateAction<number>>;
  userData: UserData;
};

export const ExerciseActive: React.FC<ExerciseActiveProps> = ({
  exercise,
  currentPromptIdx,
  setCurrentPromptIdx,
  userData,
}) => {
  const [isBreathAnimationOn, setIsBreathAnimationOn] = useState(false);
  const [isComplete, setIsComplete] = useState(false);

  const navigate = useNavigate();

  const onNext = useCallback(() => {
    setCurrentPromptIdx(currentPromptIdx + 1);
  }, [setCurrentPromptIdx, currentPromptIdx]);

  useEffect(() => {
    if (isComplete) {
      allowSleep();
    }
  }, [isComplete]);

  useEffect(() => {
    if (exercise.prompts[currentPromptIdx]?.lengthInSeconds === 0) {
      setIsBreathAnimationOn((anim) => !anim);
    }
  }, [currentPromptIdx, exercise]);

  return (
    <div className="w-full h-full flex flex-col justify-center">
      <PageHeader title={exercise.title} />
      <div className="h-1/3  flex flex-col justify-end">
        <PromptScroller
          userData={userData}
          exercise={exercise}
          onNextPrompt={onNext}
          currentPromptIdx={currentPromptIdx}
          onComplete={() => setIsComplete(true)}
        />
      </div>

      <div className="h-1/3  flex flex-col justify-start">
        <AnimatePresence>
          {isBreathAnimationOn ? (
            <motion.div
              key="breath-animation"
              className="flex flex-col gap-4 px-12 pt-8"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
              exit={{ opacity: 0 }}
            >
              <BreathAnimation userData={userData} />
            </motion.div>
          ) : null}
        </AnimatePresence>
        <AnimatePresence>
          {isComplete ? (
            <motion.div
              key="end-buttons"
              className="flex flex-col gap-4 px-12 pt-8"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
              exit={{ opacity: 0 }}
            >
              <Button onClick={() => navigate("/exercises")}>
                Back to Exercises
              </Button>
              <div className="flex justify-center text-xl">
                <FormButton
                  onClick={() => {
                    setIsComplete(false);
                    setCurrentPromptIdx(0);
                    setIsBreathAnimationOn(false);
                    preventSleep();
                  }}
                  isSelected={false}
                >
                  Restart Exercise
                </FormButton>
              </div>
            </motion.div>
          ) : null}
        </AnimatePresence>
      </div>
      <div className="h-1/3" />
      <LogFooter />
    </div>
  );
};

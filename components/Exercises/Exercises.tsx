"use client";

import React, { useEffect, useState } from "react";
import { Button, PageHeader } from "../shared";
import { FilterForm } from "./FilterForm";
import { ExerciseLine } from "./ExerciseLine";
import { ExerciseDetails } from "../../utils/types";
import { allowSleep, useNavigate } from "../../utils/client";

export type ExercisesPageProps = {
  exerciseDetails: ExerciseDetails[];
};

export const ExercisesPage: React.FC<ExercisesPageProps> = ({
  exerciseDetails,
}) => {
  const [filterFn, setFilterFn] = useState<(v: ExerciseDetails) => boolean>(
    () => () => true
  );
  useEffect(() => {
    allowSleep();
  }, []);

  const navigate = useNavigate();

  const filteredExercises = exerciseDetails.filter(filterFn);
  return (
    <>
      <PageHeader title="All Exercises" />
      <div className="flex flex-col overflow-auto">
        <FilterForm setFilterFn={setFilterFn} exercises={exerciseDetails} />
        <div className="flex flex-col gap-4 overflow-y-auto px-6">
          {filteredExercises.map((ex) => (
            <ExerciseLine key={`exercise-${ex.id}`} exerciseDetails={ex} />
          ))}
          {filteredExercises.length === 0 ? (
            <div className="italic font-light text-center opacity-70 text-lg">
              (No exercises match your current filters)
            </div>
          ) : null}
        </div>

        <div className="col-span-4 w-full p-4">
          <Button onClick={() => navigate("/exercises/*")}>
            Choose for Me
          </Button>
        </div>
      </div>
    </>
  );
};

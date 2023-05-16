import React from "react";
import { FilterDetails } from "./_types";
import { FormButton } from "../../shared";

export type ExerciseTypeFilterProps = {
  exerciseType: FilterDetails["exerciseType"];
  setExerciseType: (et: FilterDetails["exerciseType"]) => void;
};

export const ExerciseTypeFilter: React.FC<ExerciseTypeFilterProps> = ({
  exerciseType,
  setExerciseType,
}) => {
  return (
    <div className="flex flex-col gap-2 items-center">
      <label className="text-lg text-center">Exercise Types</label>
      <div className="flex flex-col lg:flex-row gap-4 text-2xl">
        <FormButton
          onClick={() => setExerciseType("all")}
          isSelected={exerciseType === "all"}
        >
          All
        </FormButton>
        <FormButton
          onClick={() => setExerciseType("favorites")}
          isSelected={exerciseType === "favorites"}
        >
          Favorites Only
        </FormButton>
      </div>
    </div>
  );
};

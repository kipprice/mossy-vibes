import React from "react";
import { FilterDetails } from "./_types";
import { FormButton, Icon } from "../../shared";
import { ExerciseTypeFilter } from "./ExerciseTypeFilter";
import { TagFilter } from "./TagFilter";
import { ExerciseDetails } from "../../../utils/types";
import { AuthorFilter } from "./AuthorFilter";
import { LengthFilter } from "./LengthFilter";

export type FilterFormProps = {
  filterDetails: FilterDetails;
  setFilterDetails: (fd: FilterDetails) => void;
  onClose: () => void;
  exercises: ExerciseDetails[];
};

export const FilterForm: React.FC<FilterFormProps> = ({
  filterDetails,
  setFilterDetails,
  onClose,
  exercises,
}) => {
  return (
    <div
      className="w-full max-w-3xl h-full text-off-white rounded-lg bg-green-dark p-4 flex flex-col items-center gap-8"
      onClick={(e) => e.stopPropagation()}
    >
      <div className="flex justify-end w-full">
        <button onClick={onClose}>
          <Icon iconFileName="circled_ex" className="w-8 h-8" />
        </button>
      </div>

      <div className="flex flex-col gap-12 overflow-y-auto w-full">
        <ExerciseTypeFilter
          exerciseType={filterDetails.exerciseType}
          setExerciseType={(exerciseType) =>
            setFilterDetails({ ...filterDetails, exerciseType })
          }
        />
        <LengthFilter
          minLength={filterDetails.minLength}
          maxLength={filterDetails.maxLength}
          setMaxLength={(maxLength) =>
            setFilterDetails({ ...filterDetails, maxLength })
          }
          setMinLength={(minLength) =>
            setFilterDetails({ ...filterDetails, minLength })
          }
        />
        <AuthorFilter
          author={filterDetails.author}
          setAuthor={(author) => setFilterDetails({ ...filterDetails, author })}
          exercises={exercises}
        />
        <TagFilter
          tag={filterDetails.tag}
          setTag={(tag) => setFilterDetails({ ...filterDetails, tag })}
          exercises={exercises}
        />
      </div>
    </div>
  );
};

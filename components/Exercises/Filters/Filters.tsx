import { motion } from "framer-motion";
import React, { useEffect, useMemo, useState } from "react";
import { ExerciseDetails } from "../../../utils/types";
import { Icon } from "../../shared";
import { FilterForm } from "./FilterForm";
import { ModeButtons } from "./ModeButtons";
import { FilterDetails, createDefaultFilterDetails } from "./_types";
import { createFilterFnFromFilterDetails } from "./createFilterFnFromFilterDetails";

export type FiltersProps = {
  exercises: ExerciseDetails[];
  setFilterFn: React.Dispatch<
    React.SetStateAction<(v: ExerciseDetails) => boolean>
  >;
};

export const Filters: React.FC<FiltersProps> = ({ setFilterFn, exercises }) => {
  const [filterDetails, setFilterDetails] = useState<FilterDetails>(
    createDefaultFilterDetails()
  );
  const [isFormVisible, setIsFormVisible] = useState(false);

  const allAuthors = new Set<string>();
  const allTags = new Set<string>();

  exercises.forEach((ex) => {
    if (ex.author) {
      allAuthors.add(ex.author);
    }
    if (ex.tags) {
      ex.tags.map((t) => allTags.add(t));
    }
  });

  useEffect(() => {
    setFilterFn(() => createFilterFnFromFilterDetails(filterDetails));
  }, [setFilterFn, filterDetails]);

  const appliedFilters = useMemo(() => {
    const { exerciseType, minLength, maxLength, tag, author } = filterDetails;
    let out = 0;
    if (exerciseType !== "all") {
      out += 1;
    }
    if (minLength !== 0 || maxLength !== Infinity) {
      out += 1;
    }
    if (tag) {
      out += 1;
    }
    if (author) {
      out += 1;
    }
    return out;
  }, [filterDetails]);

  return (
    <>
      <div className="flex px-12 pl-28 pr-[4.75rem] -mx-8 w-[calc(100%+64px)] flex-row justify-between items-center bg-green-light bg-opacity-10 py-2">
        <ModeButtons
          mode={filterDetails.mode}
          setMode={(mode) => setFilterDetails({ ...filterDetails, mode })}
        />
        {appliedFilters > 0 ? (
          <button
            className="flex text-sm items-center gap-2 px-2 py-1 rounded-lg hover:bg-off-white hover:bg-opacity-10 whitespace-nowrap opacity-70"
            onClick={() => {
              setFilterDetails(createDefaultFilterDetails(filterDetails));
            }}
          >
            Clear Filters
          </button>
        ) : null}
        <button
          className="flex items-center gap-1 p-1 rounded-lg hover:bg-off-white hover:bg-opacity-10"
          onClick={() => setIsFormVisible(true)}
        >
          <Icon iconFileName="filter" className="w-6 h-6 opacity-70" />
        </button>
      </div>

      <motion.div
        className="fixed flex justify-center items-center left-0 top-0 w-full h-full p-12 bg-off-black bg-opacity-60 z-30"
        onClick={() => setIsFormVisible(false)}
        initial={{ opacity: 0 }}
        animate={{
          opacity: isFormVisible ? 1 : 0,
          pointerEvents: isFormVisible ? "auto" : "none",
        }}
      >
        <FilterForm
          filterDetails={filterDetails}
          setFilterDetails={setFilterDetails}
          onClose={() => setIsFormVisible(false)}
          exercises={exercises}
        />
      </motion.div>
    </>
  );
};

import { motion } from "framer-motion";
import React, { useEffect, useMemo, useState } from "react";
import { FormButton, Icon } from "../shared";
import { ExerciseDetails } from "../../utils/types";

export type FilterFormProps = {
  exercises: ExerciseDetails[];
  setFilterFn: React.Dispatch<
    React.SetStateAction<(v: ExerciseDetails) => boolean>
  >;
};

export const FilterForm: React.FC<FilterFormProps> = ({
  setFilterFn,
  exercises,
}) => {
  const [exerciseType, setExerciseType] = useState<"all" | "favorites">("all");
  const [minLength, setMinLength] = useState(0);
  const [maxLength, setMaxLength] = useState(Infinity);
  const [author, setAuthor] = useState("");
  const [tag, setTag] = useState("");
  const [isFormVisible, setIsFormVisible] = useState(false);

  const authors = new Set<string>();
  const tags = new Set<string>();

  exercises.forEach((ex) => {
    if (ex.author) {
      authors.add(ex.author);
    }
    if (ex.tags) {
      ex.tags.map((t) => tags.add(t));
    }
  });

  useEffect(() => {
    setFilterFn(() => (ex: ExerciseDetails) => {
      if (exerciseType === "favorites" && !ex.isFavorite) {
        return false;
      }
      if (ex.lengthInSeconds < minLength * 60) {
        return false;
      }
      if (ex.lengthInSeconds >= maxLength * 60) {
        return false;
      }
      if (author && ex.author !== author) {
        return false;
      }
      if (tag && ex.tags.indexOf(tag) === -1) {
        return false;
      }
      return true;
    });
  }, [setFilterFn, exerciseType, minLength, maxLength, author, tag]);

  const appliedFilters = useMemo(() => {
    let out = 0;
    if (exerciseType !== "all") {
      out += 1;
    }
    if (minLength !== 0 || maxLength !== Infinity) {
      out += 1;
    }
    if (tag) {
      out +=1 
    }
    if (author) {
      out += 1
    }
    return out;
  }, [exerciseType, minLength, maxLength, tag, author]);
  return (
    <>
      <div className="flex px-12 -mx-8 w-[calc(100%+64px)] flex-row justify-between items-center bg-green-light bg-opacity-10 py-2">
        <button
          className="flex items-center gap-4 p-1 rounded-lg hover:bg-off-white hover:bg-opacity-10"
          onClick={() => setIsFormVisible(true)}
        >
          <div className="pl-2 pr-5" >
          <Icon iconFileName="filter" className="w-6 h-6 opacity-70" />
          </div>
          <span className="text-lg text-off-white text-opacity-70">
            Filters {appliedFilters ? ` (${appliedFilters} applied)` : ""}
          </span>
        </button>
        {appliedFilters > 0 ? (
          <button
            className="flex items-center gap-2 px-2 py-1 rounded-lg hover:bg-off-white hover:bg-opacity-10"
            onClick={() => {
              setExerciseType("all");
              setMinLength(0);
              setMaxLength(Infinity);
              setTag('')
              setAuthor('')
            }}
          >
            Clear
          </button>
        ) : null}
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
        <div
          className="w-full max-w-3xl h-full text-off-white rounded-lg bg-green-dark p-4 flex flex-col items-center gap-8"
          onClick={(e) => e.stopPropagation()}
        >
          <div className="flex justify-end w-full">
            <button onClick={() => setIsFormVisible(false)}>
              <Icon iconFileName="circled_ex" className="w-8 h-8" />
            </button>
          </div>

          <div className="flex flex-col gap-12 overflow-y-auto w-full">
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
            <div className="flex flex-col gap-2 items-center">
              <label className="text-lg text-center">Exercise Length</label>
              <div className="flex flex-col lg:flex-row gap-4 text-2xl">
                <FormButton
                  onClick={() => {
                    setMinLength(0);
                    setMaxLength(Infinity);
                  }}
                  isSelected={minLength === 0 && maxLength === Infinity}
                >
                  All
                </FormButton>
                <FormButton
                  onClick={() => {
                    setMinLength(0);
                    setMaxLength(5);
                  }}
                  isSelected={minLength === 0 && maxLength === 5}
                >
                  &lt; 5 mins
                </FormButton>
                <FormButton
                  onClick={() => {
                    setMinLength(5);
                    setMaxLength(10);
                  }}
                  isSelected={minLength === 5 && maxLength === 10}
                >
                  5 - 9 mins
                </FormButton>
                <FormButton
                  onClick={() => {
                    setMinLength(10);
                    setMaxLength(15);
                  }}
                  isSelected={minLength === 10 && maxLength === 15}
                >
                  10 - 15 mins
                </FormButton>
                <FormButton
                  onClick={() => {
                    setMinLength(15);
                    setMaxLength(Infinity);
                  }}
                  isSelected={minLength === 15 && maxLength === Infinity}
                >
                  &gt; 15 mins
                </FormButton>
              </div>
            </div>
            <div className="flex flex-col gap-2 items-center">
              <label className="text-lg text-center">Authors</label>
              <div className="flex flex-col lg:flex-row gap-4 text-2xl lg:flex-wrap">
              <FormButton onClick={() => setAuthor('')} isSelected={!author}>
                  All authors
                </FormButton>
                {[...authors].map((a) => (
                  <FormButton
                    key={`author-${a}`}
                    onClick={() => setAuthor(a)}
                    isSelected={author === a}
                  >
                    {a}
                  </FormButton>
                ))}
              </div>
            </div>
            <div className="flex flex-col gap-2 items-center">
              <label className="text-lg text-center">Tags</label>
              <div className="flex flex-col lg:flex-row gap-4 text-2xl lg:flex-wrap">
                <FormButton onClick={() => setTag('')} isSelected={!tag}>
                  All tags
                </FormButton>
                {[...tags].map((t) => (
                  <FormButton
                    key={`tag-${t}`}
                    onClick={() => setTag(t)}
                    isSelected={tag === t}
                  >
                    #{t}
                  </FormButton>
                ))}
              </div>
            </div>
          </div>
        </div>
      </motion.div>
    </>
  );
};

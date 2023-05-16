import React from "react";
import { FilterDetails } from "./_types";
import { FormButton } from "../../shared";
import { ExerciseDetails } from "../../../utils/types";

export type TagFilterProps = {
  tag: FilterDetails["tag"];
  setTag: (t: FilterDetails["tag"]) => void;
  exercises: ExerciseDetails[];
};

export const TagFilter: React.FC<TagFilterProps> = ({
  tag,
  setTag,
  exercises,
}) => {
  const allTags = new Set<string>();

  exercises.forEach((ex) => {
    if (ex.tags) {
      ex.tags.map((t) => allTags.add(t));
    }
  });

  return (
    <div className="flex flex-col gap-2 items-center">
      <label className="text-lg text-center">Tags</label>
      <div className="flex flex-col lg:flex-row gap-4 text-2xl lg:flex-wrap">
        <FormButton onClick={() => setTag("")} isSelected={!tag}>
          All Tags
        </FormButton>
        {[...allTags].map((t) => (
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
  );
};

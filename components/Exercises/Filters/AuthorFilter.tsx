import React from "react";
import { FilterDetails } from "./_types";
import { ExerciseDetails } from "../../../utils/types";
import { FormButton } from "../../shared";

export type AuthorFilterProps = {
  author: FilterDetails["author"];
  setAuthor: (a: FilterDetails["author"]) => void;
  exercises: ExerciseDetails[];
};

export const AuthorFilter: React.FC<AuthorFilterProps> = ({
  author,
  setAuthor,
  exercises,
}) => {
  const authors = new Set<string>();

  exercises.forEach((ex) => {
    if (ex.author) {
      authors.add(ex.author);
    }
  });

  return (
    <div className="flex flex-col gap-2 items-center">
      <label className="text-lg text-center">Authors</label>
      <div className="flex flex-col lg:flex-row gap-4 text-2xl lg:flex-wrap">
        <FormButton onClick={() => setAuthor("")} isSelected={!author}>
          All Authors
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
  );
};

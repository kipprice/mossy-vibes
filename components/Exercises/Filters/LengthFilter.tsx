import React from "react";
import { FilterDetails } from "./_types";
import { FormButton } from "../../shared";

export type LengthFilterProps = {
  minLength: FilterDetails["minLength"];
  maxLength: FilterDetails["maxLength"];
  setLength: ({
    min,
    max,
  }: {
    min: FilterDetails["minLength"];
    max: FilterDetails["maxLength"];
  }) => void;
};

export const LengthFilter: React.FC<LengthFilterProps> = ({
  maxLength,

  minLength,
  setLength,
}) => {
  return (
    <div className="flex flex-col gap-2 items-center">
      <label className="text-lg text-center">Exercise Length</label>
      <div className="flex flex-col lg:flex-row gap-4 text-2xl">
        <FormButton
          onClick={() => {
            setLength({ min: 0, max: Infinity });
          }}
          isSelected={minLength === 0 && maxLength === Infinity}
        >
          All
        </FormButton>
        <FormButton
          onClick={() => {
            setLength({ min: 0, max: 5 });
          }}
          isSelected={minLength === 0 && maxLength === 5}
        >
          &lt; 5 mins
        </FormButton>
        <FormButton
          onClick={() => {
            setLength({ min: 5, max: 10 });
          }}
          isSelected={minLength === 5 && maxLength === 10}
        >
          5 - 9 mins
        </FormButton>
        <FormButton
          onClick={() => {
            setLength({ min: 10, max: 15 });
          }}
          isSelected={minLength === 10 && maxLength === 15}
        >
          10 - 15 mins
        </FormButton>
        <FormButton
          onClick={() => {
            setLength({ min: 15, max: Infinity });
          }}
          isSelected={minLength === 15 && maxLength === Infinity}
        >
          &gt; 15 mins
        </FormButton>
      </div>
    </div>
  );
};

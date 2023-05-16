import React from "react";
import { FilterDetails } from "./_types";
import { FormButton } from "../../shared";

export type LengthFilterProps = {
  minLength: FilterDetails["minLength"];
  maxLength: FilterDetails["maxLength"];
  setMinLength: (l: FilterDetails["minLength"]) => void;
  setMaxLength: (l: FilterDetails["maxLength"]) => void;
};

export const LengthFilter: React.FC<LengthFilterProps> = ({
  maxLength,
  setMaxLength,
  minLength,
  setMinLength,
}) => {
  return (
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
  );
};

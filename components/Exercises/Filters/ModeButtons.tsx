import React from "react";
import { FilterDetails } from "./_types";

export type ModeButtonsProps = {
  mode: FilterDetails["mode"];
  setMode: (m: FilterDetails["mode"]) => void;
};

export const ModeButtons: React.FC<ModeButtonsProps> = ({ mode, setMode }) => {
  return (
    <div className="flex w-full">
      <button
        className={`${modeClassName} opacity-${mode === "standard" ? 80 : 50}`}
        onClick={() => setMode("standard")}
      >
        Standard
      </button>
      <button
        className={`${modeClassName} opacity-${mode === "micro" ? 80 : 50}`}
        onClick={() => setMode("micro")}
      >
        Micro
      </button>
    </div>
  );
};

const modeClassName = "text-lg font-base p-2";

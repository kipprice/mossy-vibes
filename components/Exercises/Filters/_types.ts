export type FilterDetails = {
  mode: "standard" | "micro";
  exerciseType: "all" | "favorites";
  minLength: number;
  maxLength: number;
  author: string;
  tag: string;
};

export const createDefaultFilterDetails = (
  lastDetails?: FilterDetails
): FilterDetails => {
  return {
    mode: lastDetails ? lastDetails.mode : "standard",
    author: "",
    tag: "",
    exerciseType: "all",
    maxLength: Infinity,
    minLength: 0,
  };
};

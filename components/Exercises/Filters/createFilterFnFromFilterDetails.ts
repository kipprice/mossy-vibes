import { ExerciseDetails } from "@/utils/types";
import { FilterDetails } from "./_types";

export const createFilterFnFromFilterDetails = (
  filterDetails: FilterDetails
) => {
  return (ex: ExerciseDetails) => {
    const { mode, author, exerciseType, maxLength, minLength, tag } =
      filterDetails;
    const isMicro = ex.tags.includes("micro");
    if (mode === "standard" && isMicro) {
      return false;
    }
    if (mode === "micro" && !isMicro) {
      return false;
    }

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
  };
};

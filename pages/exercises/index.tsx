import { Exercises } from "../../components/Exercises/Exercises";
import { useGetAllExerciseDetails } from "../../utils/client";
import { exerciseFilenames, loadAllExercises } from "../../utils/server";
import { ParsedExercise } from "../../utils/types";

export const getStaticProps = async () => {
  const exercises = await loadAllExercises()
  return {
    props: {
      exercises
    },
  };
};

export const Page: React.FC<{ exercises: ParsedExercise[] }> = ({
  exercises,
}) => {
  const exerciseDetails = useGetAllExerciseDetails(exercises);
  return <Exercises exerciseDetails={exerciseDetails} />;
};

export default Page;

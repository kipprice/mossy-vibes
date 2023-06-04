import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/preferences.dart';

import 'exercise_length.dart';

enum ExerciseType {
  all,
  favorites;
}

class Filters {
  /// The exercise size the user is currently showing.
  ///
  /// Unlike all other filters, this is configured through a tab view, so it
  /// is not accounted for in the same way as all of the other filters.
  ExerciseSize exerciseSize = ExerciseSize.normal;

  /// Allows for viewing only favorite exercises.
  ExerciseType exerciseType = ExerciseType.all;

  /// Allows exercises to be selectively shown based on the length of time it
  /// will take to go through them.
  ExerciseLength exerciseLength = ExerciseLength.all;

  /// Allows for filtering exercises to only those written by the specified
  /// [author].
  String author = '';

  /// Allows for filtering exercises to only those containing the specified
  /// [tag].
  String tag = '';

  /// Tracks any specific filtering the user has elected to do on a list of
  /// available exercises.
  ///
  /// The Filters object is only used on the ExercisesScreen, and helps
  /// consolidate the different ways a user might choose to refine a list of
  /// exercises. It has built in capabilities to
  Filters(
      {this.exerciseSize = ExerciseSize.normal,
      this.exerciseType = ExerciseType.all,
      this.exerciseLength = ExerciseLength.all,
      this.author = '',
      this.tag = ''});

  /// Determines how many filters are currently limiting the set of Exercises
  /// that can be viewed
  int get appliedCount {
    int count = 0;
    if (exerciseType != ExerciseType.all) {
      count += 1;
    }

    if (exerciseLength != ExerciseLength.all) {
      count += 1;
    }

    if (author.isNotEmpty) {
      count += 1;
    }

    if (tag.isNotEmpty) {
      count += 1;
    }

    return count;
  }

  /// Resets all of the filters (except exerciseSize) back to their un-set
  /// status.
  ///
  /// [clear] does not change the current [exerciseSize] filter, as that is
  /// managed through a different mechanism.
  void clear() {
    exerciseType = ExerciseType.all;
    exerciseLength = ExerciseLength.all;
    author = '';
    tag = '';
  }

  /// Determines whether a particular exercise should be shown to a user.
  ///
  /// This function is called by individual ExerciseLists in order to
  /// determine which exercises should be visible to the user. It does not
  /// take [exerciseSize] into account, though, as there is a different
  /// mechanism for showing or hiding based on the ExerciseSize.
  bool shouldShowExercise(Exercise exercise, UserPreferences preferences) {
    if (exerciseType == ExerciseType.favorites &&
        !exercise.isFavorite(preferences)) {
      return false;
    }

    final length = exercise.getLengthInMinutes(preferences).toDouble();

    if (length < exerciseLength.min) {
      return false;
    }

    if (length >= exerciseLength.max) {
      return false;
    }

    if (author.isNotEmpty && exercise.author != author) {
      return false;
    }

    if (tag.isNotEmpty &&
        exercise.tags != null &&
        !exercise.tags!.contains(tag)) {
      return false;
    }

    return true;
  }
}

import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/exercise_length.dart';
import 'package:mossy_vibes/src/models/filters.dart';
import 'package:mossy_vibes/src/models/preferences.dart';
import 'package:test/test.dart';

void main() {
  group('The Filters model', () {
    test('can be created with specific properties', () {
      final f = Filters(
          author: 'author',
          tag: 'tag',
          exerciseLength: ExerciseLength.underFive,
          exerciseSize: ExerciseSize.micro,
          exerciseType: ExerciseType.favorites);
      expect(f.author, 'author');
      expect(f.tag, 'tag');
      expect(f.exerciseLength, ExerciseLength.underFive);
      expect(f.exerciseType, ExerciseType.favorites);
      expect(f.exerciseSize, ExerciseSize.micro);
    });

    test('can be created with appropriate defaults', () {
      final f = Filters();
      expect(f.author, '');
      expect(f.tag, '');
      expect(f.exerciseLength, ExerciseLength.all);
      expect(f.exerciseType, ExerciseType.all);
      expect(f.exerciseSize, ExerciseSize.normal);
    });

    group('(when calculating the number of applied filters)', () {
      test('can calculate the number of currently applied filters', () {
        final f = Filters(
            author: 'author',
            tag: 'tag',
            exerciseLength: ExerciseLength.underFive,
            exerciseType: ExerciseType.favorites);
        expect(f.appliedCount, 4);
      });

      test('does not count the exercise size in the filter count', () {
        final f = Filters(exerciseSize: ExerciseSize.micro);
        expect(f.appliedCount, 0);
      });
    });

    group('(when clearing filters)', () {
      test('does not do anything if the filters are already clear', () {
        final f = Filters();
        f.clear();
        expect(f.appliedCount, 0);
      });

      test('clears all current filters', () {
        final f = Filters(
            author: 'author',
            tag: 'tag',
            exerciseLength: ExerciseLength.underFive,
            exerciseType: ExerciseType.favorites,
            exerciseSize: ExerciseSize.micro);
        f.clear();
        expect(f.appliedCount, 0);
      });

      test('does not clear exercise size', () {
        final f = Filters(
            author: 'author',
            tag: 'tag',
            exerciseLength: ExerciseLength.underFive,
            exerciseType: ExerciseType.favorites,
            exerciseSize: ExerciseSize.micro);
        f.clear();
        expect(f.exerciseSize, ExerciseSize.micro);
      });
    });

    group('(when determining if an exercise should show)', () {
      test('it shows an exercise with a matching author', () {
        final f = Filters(author: 'test');
        final e = Exercise(id: 'exercise', author: 'test');

        expect(f.shouldShowExercise(e, UserPreferences()), true);
      });

      test('it hides an exercise without a matching author', () {
        final f = Filters(author: 'test');
        final e = Exercise(id: 'exercise', author: 'not-test');

        expect(f.shouldShowExercise(e, UserPreferences()), false);
      });

      test('it shows an exercise with a matching tag', () {
        final f = Filters(tag: 'test');
        final e = Exercise(id: 'exercise', tags: ['test']);

        expect(f.shouldShowExercise(e, UserPreferences()), true);
      });

      test('it hides an exercise without a matching tag', () {
        final f = Filters(tag: 'test');
        final e = Exercise(id: 'exercise', tags: ['not-test', 'other']);

        expect(f.shouldShowExercise(e, UserPreferences()), false);
      });

      test('it shows an exercise with a matching exercise length', () {
        final f = Filters(exerciseLength: ExerciseLength.underFive);
        final e = Exercise(id: 'exercise', prompts: []);

        expect(f.shouldShowExercise(e, UserPreferences()), true);
      });

      test('it hides an exercise without a matching author', () {
        final f = Filters(exerciseLength: ExerciseLength.overFifteen);
        final e = Exercise(id: 'exercise', prompts: []);

        expect(f.shouldShowExercise(e, UserPreferences()), false);
      });

      test('it shows an exercise with a favorite status', () {
        final f = Filters(exerciseType: ExerciseType.favorites);
        final e = Exercise(id: 'exercise');

        expect(
            f.shouldShowExercise(e, UserPreferences(favorites: ['exercise'])),
            true);
      });

      test('it hides an exercise without a matching favorite status', () {
        final f = Filters(exerciseType: ExerciseType.favorites);
        final e = Exercise(id: 'exercise');

        expect(
            f.shouldShowExercise(
                e, UserPreferences(favorites: ['not-exercise'])),
            false);
      });

      test('it does not filter on exercise size', () {
        final f = Filters(exerciseSize: ExerciseSize.micro);
        final e = Exercise(id: 'exercise', size: ExerciseSize.normal);

        expect(f.shouldShowExercise(e, UserPreferences()), true);
      });
    });
  });
}

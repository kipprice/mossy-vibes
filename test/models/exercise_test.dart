import 'package:mossy_vibes/src/models/completion_audit.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/preferences.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:test/test.dart';

void main() {
  group('An Exercise', () {
    test('can be created with specific details', () {
      final instant = DateTime(2023, 1, 1);
      final prompt = Prompt(content: 'This is a prompt', type: BreathType.full);
      final e = Exercise(
          id: 'exercise-id',
          author: 'author',
          tags: ['tag'],
          title: 'Example Exercise',
          dateAdded: instant,
          size: ExerciseSize.normal,
          prompts: [prompt]);
      expect(e.id, 'exercise-id');
      expect(e.author, 'author');
      expect(e.tags, ['tag']);
      expect(e.dateAdded, instant);
      expect(e.title, 'Example Exercise');
      expect(e.size, ExerciseSize.normal);
      expect(e.prompts, [prompt]);
    });

    test('can be created with just an exercise id', () {
      final e = Exercise(id: 'exercise-id');
      expect(e.id, 'exercise-id');
      expect(e.prompts, []);
    });

    group('(when getting the length of the exercise in seconds))', () {
      test('can calculate its own length', () {
        final e = Exercise(id: 'exercise-id', prompts: [
          Prompt(type: BreathType.full, content: 'This is a prompt')
        ]);
        final prefs = UserPreferences();
        expect(
            e.getLengthInSeconds(prefs), prefs.calculateFullBreathInSeconds());
      });

      test('can calculate that with zero prompts, the exercise has zero length',
          () {
        final e = Exercise(id: 'exercise-id', prompts: []);
        final prefs = UserPreferences();
        expect(e.getLengthInSeconds(prefs), 0);
      });
    });

    group('(when getting the length of the exercise in minutes))', () {
      test('can calculate its own length', () {
        Prompt p = Prompt(type: BreathType.full, content: 'This is a prompt');
        final e = Exercise(id: 'exercise-id', prompts: [p, p, p, p, p]);
        final prefs = UserPreferences();
        expect(e.getLengthInMinutes(prefs), 2);
      });

      test('rounds up the minute count', () {
        final e = Exercise(id: 'exercise-id', prompts: [
          Prompt(type: BreathType.full, content: 'This is a prompt')
        ]);
        final prefs = UserPreferences();
        expect(e.getLengthInMinutes(prefs), 1);
      });

      test('can calculate that with zero prompts, the exercise has zero length',
          () {
        final e = Exercise(id: 'exercise-id', prompts: []);
        final prefs = UserPreferences();
        expect(e.getLengthInMinutes(prefs), 0);
      });
    });

    group('(when determining if the Exercise is a favorite)', () {
      test('can determine that an exercise in the favorites list is a favorite',
          () {
        final e = Exercise(id: 'exercise-id');
        final prefs = UserPreferences(favorites: ['exercise-id']);
        expect(e.isFavorite(prefs), true);
      });

      test(
          'can determine that an exercise not in the favorites list is not a favorite',
          () {
        final e = Exercise(id: 'exercise-id');
        final prefs = UserPreferences(favorites: ['not-exercise-id']);
        expect(e.isFavorite(prefs), false);
      });
    });

    group('(when determining if the Exercise is completed)', () {
      test(
          'can determine that an exercise with a completion audit is completed',
          () {
        final e = Exercise(id: 'exercise-id');
        final prefs = UserPreferences(completedExercises: [
          CompletionAudit(
              exerciseId: 'exercise-id',
              completedAt: DateTime.now(),
              lengthOfExerciseInMinutes: 2)
        ]);
        expect(e.isCompleted(prefs), true);
      });

      test(
          'can determine that an exercise without a completion audit is not completed',
          () {
        final e = Exercise(id: 'exercise-id');
        final prefs = UserPreferences(completedExercises: [
          CompletionAudit(
              exerciseId: 'not-exercise-id',
              completedAt: DateTime.now(),
              lengthOfExerciseInMinutes: 2)
        ]);
        expect(e.isCompleted(prefs), false);
      });
    });

    group('(when serializing to JSON)', () {
      test('can create a JSON version of the model', () {
        final instant = DateTime(2023, 1, 1);
        final prompt =
            Prompt(content: 'This is a prompt', type: BreathType.full);
        final e = Exercise(
            id: 'exercise-id',
            author: 'author',
            tags: ['tag'],
            title: 'Example Exercise',
            dateAdded: instant,
            size: ExerciseSize.normal,
            prompts: [prompt]);

        expect(e.toJson(), {
          'id': 'exercise-id',
          'author': 'author',
          'tags': ['tag'],
          'title': 'Example Exercise',
          'dateAdded': '2023-01-01T00:00:00.000',
          'size': 'normal',
          'prompts': [
            {'content': 'This is a prompt', 'type': 'full'}
          ]
        });
      });

      test('can serialize even if nullable values are null', () {
        final e = Exercise(id: 'exercise-id', prompts: []);

        expect(e.toJson(), {
          'id': 'exercise-id',
          'author': null,
          'tags': null,
          'title': null,
          'dateAdded': '',
          'size': 'normal',
          'prompts': []
        });
      });
    });

    group('(when deserializing from JSON)', () {
      test('can generate an Exercise model from its JSON representation', () {
        const json = {
          'id': 'exercise-id',
          'author': 'author',
          'tags': ['tag'],
          'title': 'Example Exercise',
          'dateAdded': '2023-01-01T00:00:00.000',
          'size': 'normal',
          'prompts': [
            {'content': 'This is a prompt', 'type': 'full'}
          ]
        };
        final parsedExercise = Exercise.fromJson(json);
        expect(parsedExercise.id, 'exercise-id');
        expect(parsedExercise.author, 'author');
        expect(parsedExercise.tags, ['tag']);
        expect(parsedExercise.dateAdded, DateTime(2023, 1, 1));
        expect(parsedExercise.prompts, isA<List<Prompt>>());
        expect(parsedExercise.title, 'Example Exercise');
      });

      test(
          'can generate an Exercise model from a JSON representation with hull values',
          () {
        const json = {
          'id': 'exercise-id',
          'author': null,
          'tags': null,
          'title': null,
          'dateAdded': '',
          'size': 'normal',
          'prompts': []
        };

        final parsedExercise = Exercise.fromJson(json);
        expect(parsedExercise, isA<Exercise>());
      });
    });
  });
}

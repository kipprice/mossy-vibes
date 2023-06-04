import 'package:mossy_vibes/src/models/breath_pattern.dart';
import 'package:mossy_vibes/src/models/completion_audit.dart';
import 'package:mossy_vibes/src/models/preferences.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:test/test.dart';

void main() {
  group('UserPreferences', () {
    test('can be created with specific properties', () {
      final audit = CompletionAudit(
          exerciseId: 'test',
          completedAt: DateTime.now(),
          lengthOfExerciseInMinutes: 2);

      final prefs = UserPreferences(
          breathPattern: BreathPattern.relaxed,
          completedExercises: [audit],
          favorites: const ['test'],
          readingSpeedInWpm: 75);

      expect(prefs.readingSpeedInWpm, 75);
      expect(prefs.breathPattern, BreathPattern.relaxed);
      expect(prefs.favorites, const ['test']);
      expect(prefs.completedExercises, [audit]);
    });

    test('can be created with appropriate defaults', () {
      final prefs = UserPreferences();
      expect(prefs.readingSpeedInWpm, isA<int>());
      expect(prefs.breathPattern, isA<BreathPattern>());
      expect(prefs.completedExercises, isA<List>());
      expect(prefs.favorites, isA<List>());
    });

    group('(when accessing breath lengths)', () {
      test('can retrieve the breath intake length', () {
        final prefs = UserPreferences(breathPattern: BreathPattern.calm);
        expect(prefs.inBreathInSeconds, isA<int>());
      });

      test('can retrieve the breath hold length', () {
        final prefs = UserPreferences(breathPattern: BreathPattern.calm);
        expect(prefs.holdBreathInSeconds, isA<int>());
      });

      test('can retrieve the breath out length', () {
        final prefs = UserPreferences(breathPattern: BreathPattern.calm);
        expect(prefs.outBreathInSeconds, isA<int>());
      });

      test('can retrieve the breath padding length', () {
        final prefs = UserPreferences(breathPattern: BreathPattern.calm);
        expect(prefs.paddingInSeconds, isA<int>());
      });

      test('can calculate the length of a full breath', () {
        const pattern = BreathPattern.relaxed;
        final prefs = UserPreferences(breathPattern: pattern);
        expect(prefs.calculateFullBreathInSeconds(),
            pattern.intake + pattern.hold + pattern.out + pattern.padding);
      });

      test(
          'can calculate the ratio of time a full breath is spent breathing in',
          () {
        const pattern = BreathPattern.relaxed;
        final fullBreath =
            pattern.intake + pattern.hold + pattern.out + pattern.padding;
        final prefs = UserPreferences(breathPattern: pattern);
        expect(prefs.calculateBreathRatio(BreathType.intake),
            pattern.intake / fullBreath);
      });

      test('can calculate the ratio of time a full breath is spent held', () {
        const pattern = BreathPattern.relaxed;
        final fullBreath =
            pattern.intake + pattern.hold + pattern.out + pattern.padding;
        final prefs = UserPreferences(breathPattern: pattern);
        expect(prefs.calculateBreathRatio(BreathType.hold),
            pattern.hold / fullBreath);
      });

      test(
          'can calculate the ratio of time a full breath is spent breathing out',
          () {
        const pattern = BreathPattern.relaxed;
        final fullBreath =
            pattern.intake + pattern.hold + pattern.out + pattern.padding;
        final prefs = UserPreferences(breathPattern: pattern);
        expect(prefs.calculateBreathRatio(BreathType.out),
            pattern.out / fullBreath);
      });

      test(
          'can calculate the ratio of time a full breath is spent waiting for the next breath',
          () {
        const pattern = BreathPattern.relaxed;
        final fullBreath =
            pattern.intake + pattern.hold + pattern.out + pattern.padding;
        final prefs = UserPreferences(breathPattern: pattern);
        expect(prefs.calculatePaddingRatio(), pattern.padding / fullBreath);
      });
    });

    group('(when accessing reading speed)', () {
      test('can calculate how many seconds each word takes', () {
        final prefs = UserPreferences(readingSpeedInWpm: 80);
        expect(prefs.calculateSecondsPerWord(), 0.75);
      });
    });

    group('(when converting to JSON)', () {
      test('can create a JSON representation of its data', () {
        final instant = DateTime(2023, 1, 1);
        final audit = CompletionAudit(
            exerciseId: 'test',
            completedAt: instant,
            lengthOfExerciseInMinutes: 2);
        final prefs = UserPreferences(
            breathPattern: BreathPattern.calm,
            readingSpeedInWpm: 100,
            completedExercises: [audit],
            favorites: ['test']);
        expect(prefs.toJson(), {
          'breathPattern': 'calm',
          'readingSpeedInWpm': 100,
          'favorites': ['test'],
          'completedExercises': [
            {
              'exerciseId': 'test',
              'completedAt': '2023-01-01T00:00:00.000',
              'lengthOfExerciseInMinutes': 2
            }
          ]
        });
      });
    });

    group('(when translating from JSON)', () {
      test('can parse out a reading speed from JSON', () {
        final prefs = UserPreferences();
        prefs.parseJson({'readingSpeedInWpm': 100});
        expect(prefs.readingSpeedInWpm, 100);
      });

      test('can parse out a breath pattern from JSON', () {
        final prefs = UserPreferences();
        prefs.parseJson({'breathPattern': 'quick'});
        expect(prefs.breathPattern, BreathPattern.quick);
      });

      test('can parse out a set of favorites from JSON', () {
        final prefs = UserPreferences();
        prefs.parseJson({
          'favorites': ['test']
        });
        expect(prefs.favorites, ['test']);
      });

      test('can parse out a set of completion audits from JSON', () {
        final prefs = UserPreferences();
        prefs.parseJson({
          'completedExercises': [
            {
              'exerciseId': 'test',
              'completedAt': '2023-01-01T00:00:00.000',
              'lengthOfExerciseInMinutes': 2
            }
          ]
        });
        expect(prefs.completedExercises, hasLength(1));
      });
    });
  });
}

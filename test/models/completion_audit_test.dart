import 'package:mossy_vibes/src/models/completion_audit.dart';
import 'package:test/test.dart';

void main() {
  group('A CompletionAudit', () {
    test('can be created with the appropriate data', () {
      final instant = DateTime(2023, 1, 1);
      final audit = CompletionAudit(
          exerciseId: 'test',
          completedAt: instant,
          lengthOfExerciseInMinutes: 3);
      expect(audit.exerciseId, 'test');
      expect(audit.completedAt, instant);
    });

    group('(when serializing json)', () {
      test('can be translated into a JSON representation', () {
        final instant = DateTime(2023, 1, 1);
        final audit = CompletionAudit(
            exerciseId: 'test',
            completedAt: instant,
            lengthOfExerciseInMinutes: 3);
        final json = audit.toJson();
        expect(json, {
          'exerciseId': 'test',
          'completedAt': '2023-01-01T00:00:00.000',
          'lengthOfExerciseInMinutes': 3
        });
      });
    });

    group('(when deserializing json)', () {
      test('can be created out of a json representation', () {
        final instant = DateTime(2023, 1, 1);
        final jsonAudit = CompletionAudit.fromJson({
          'exerciseId': 'test',
          'completedAt': '2023-01-01T00:00:00.000',
          'lengthOfExerciseInMinutes': 3
        });
        expect(jsonAudit.completedAt, instant);
        expect(jsonAudit.exerciseId, 'test');
        expect(jsonAudit.lengthOfExerciseInMinutes, 3);
      });

      test(
          'handles if the json it is created from does not have a completion instant',
          () {
        final jsonAudit = CompletionAudit.fromJson(
            {'exerciseId': 'test', 'lengthOfExerciseInMinutes': 3});
        expect(jsonAudit.completedAt, (completedAt) => completedAt is DateTime);
      });

      test(
          'handles if the json it is created from does not have a length in minutes',
          () {
        final jsonAudit = CompletionAudit.fromJson(
            {'exerciseId': 'test', 'completedAt': '2023-01-01T00:00:00.000'});
        expect(jsonAudit.lengthOfExerciseInMinutes, 0);
      });

      test(
          'throws an exception if there is not an exercise ID specified in the json',
          () {
        expect(
            () => CompletionAudit.fromJson({
                  'completedAt': '2023-01-01T00:00:00.000',
                  'lengthOfExerciseInMinutes': 3
                }),
            throwsFormatException);
      });
    });
  });
}

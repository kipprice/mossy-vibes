import 'package:mossy_vibes/src/models/breath_pattern.dart';
import 'package:mossy_vibes/src/models/preferences.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:test/test.dart';

void main() {
  group('A Prompt', () {
    test('can be created with relevant content', () {
      final p = Prompt(type: BreathType.intake, content: 'This is a prompt');
      expect(p.content, 'This is a prompt');
      expect(p.type, BreathType.intake);
    });

    test('can be created as a toggle', () {
      final p = Prompt.breathToggle();
      expect(p.type, BreathType.toggle);
    });

    group('(when calculating the length of the prompt)', () {
      const promptText = 'One two three four five six';
      final preferences = UserPreferences(
          breathPattern: BreathPattern.calm, readingSpeedInWpm: 120);

      test(
          'can calculate the prompt length when the prompt is tied to a full breath',
          () {
        final p = Prompt(type: BreathType.full, content: promptText);
        expect(p.getLengthInSeconds(preferences),
            preferences.calculateFullBreathInSeconds());
      });

      test(
          'can calculate the prompt length when the prompt is tied to an in breath',
          () {
        final p = Prompt(type: BreathType.intake, content: promptText);
        expect(
            p.getLengthInSeconds(preferences), preferences.inBreathInSeconds);
      });

      test(
          'can calculate the prompt length when the prompt is tied to a breath hold',
          () {
        final p = Prompt(type: BreathType.hold, content: promptText);
        expect(
            p.getLengthInSeconds(preferences), preferences.holdBreathInSeconds);
      });

      test(
          'can calculate the prompt length when the prompt is tied to an out breath',
          () {
        final p = Prompt(type: BreathType.out, content: promptText);
        expect(p.getLengthInSeconds(preferences),
            preferences.outBreathInSeconds + preferences.paddingInSeconds);
      });

      test(
          'can calculate the prompt length when the prompt is not tied to a breath',
          () {
        final p = Prompt(type: BreathType.none, content: promptText);
        expect(p.getLengthInSeconds(preferences),
            3 + preferences.paddingInSeconds);
      });

      test('can calculate the prompt length when the prompt is a toggle', () {
        final p = Prompt(type: BreathType.toggle, content: promptText);
        expect(p.getLengthInSeconds(preferences), 0);
      });

      test(
          'can round to the nearest full breath if the reading speed requires more time than the breath allows',
          () {
        final p =
            Prompt(type: BreathType.out, content: '$promptText $promptText');
        expect(p.getLengthInSeconds(preferences),
            preferences.calculateFullBreathInSeconds());
      });

      test(
          'can round up to the nearest intake breath if the reading speed requires more time than the breath allows',
          () {
        final p = Prompt(
            type: BreathType.intake,
            content:
                '$promptText $promptText $promptText $promptText $promptText $promptText'); // 36 words, 18 seconds
        expect(
            p.getLengthInSeconds(preferences),
            preferences.calculateFullBreathInSeconds() * 2 +
                preferences.inBreathInSeconds);
      });

      test(
          'can round to the nearest intake breath if the reading speed requires more time than the breath allows',
          () {
        final p = Prompt(
            type: BreathType.intake,
            content:
                '$promptText $promptText $promptText $promptText $promptText'); // 30 words, 15 seconds
        expect(
            p.getLengthInSeconds(preferences),
            preferences.calculateFullBreathInSeconds() +
                preferences.inBreathInSeconds);
      });

      test(
          'can round up to the nearest held breath if the reading speed requires more time than the breath allows',
          () {
        final p = Prompt(
            type: BreathType.hold,
            content:
                '$promptText $promptText $promptText $promptText $promptText $promptText $promptText $promptText'); // 48 words, 24 seconds
        expect(
            p.getLengthInSeconds(preferences),
            (preferences.calculateFullBreathInSeconds() * 2) +
                preferences.inBreathInSeconds +
                preferences.holdBreathInSeconds);
      });

      test(
          'can round to the nearest held breath if the reading speed requires more time than the breath allows',
          () {
        final p = Prompt(
            type: BreathType.hold,
            content:
                '$promptText $promptText $promptText $promptText $promptText $promptText $promptText'); // 42 words, 21 seconds
        expect(
            p.getLengthInSeconds(preferences),
            preferences.calculateFullBreathInSeconds() +
                preferences.inBreathInSeconds +
                preferences.holdBreathInSeconds);
      });
    });

    group('(when splitting into words)', () {
      test('can break a single sentence into words', () {
        final p = Prompt(type: BreathType.full, content: 'This is a prompt');
        expect(p.splitIntoWords(), ['This', 'is', 'a', 'prompt']);
      });

      test('can break multiple sentences into lines and words', () {
        final p = Prompt(
            type: BreathType.full,
            content: 'This is a prompt; it should be broken up');
        expect(p.splitIntoWords(), [
          'This',
          'is',
          'a',
          'prompt;',
          '¶',
          'it',
          'should',
          'be',
          'broken',
          'up'
        ]);
      });

      test('removes any extra trailing line breaks', () {
        final p = Prompt(type: BreathType.full, content: 'This is a prompt.');
        expect(p.splitIntoWords(), ['This', 'is', 'a', 'prompt.']);
      });

      test('splits an empty string', () {
        final p = Prompt(type: BreathType.intake, content: '');
        expect(p.splitIntoWords(), isEmpty);
      });
    });

    group('(when converting to JSON)', () {
      test('can convert the model into JSON format', () {
        final p = Prompt(type: BreathType.intake, content: 'This is a prompt');
        expect(p.toJson(), {'type': 'intake', 'content': 'This is a prompt'});
      });
    });

    group('(when parsing a prompt out of JSON)', () {
      test('can convert a JSON object to a Prompt', () {
        final parsedPrompt =
            Prompt.fromJson({'type': 'intake', 'content': 'This is a prompt'});
        expect(parsedPrompt.content, 'This is a prompt');
        expect(parsedPrompt.type, BreathType.intake);
      });
    });
  });
}

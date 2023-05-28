import '../utils/enum_value_from_json.dart';
import 'preferences.dart';

enum BreathType { full, intake, hold, out, none, toggle }

class Prompt {
  /// The actual text making up this Prompt.
  ///
  /// This is allowed to be empty, which will either be treated as an unprompted
  /// piece of a breath, or as a toggle for the breath animation.
  final String content;

  /// the type of breath this prompt is associated with.
  ///
  /// Used to determine the amount of time this prompt will be shown for.
  final BreathType type;

  /// A piece of text that is associated with a particular breath-focused
  /// timing.
  ///
  /// Prompts are generated from a single or partial line stored within the
  /// exercise markdown. The ExerciseParser helps determine what breath type this
  /// Prompt is associated with. Generally, full lines in Markdown are converted
  /// into Prompts with BreathType.full, and partial lines are convered into
  /// Prompts with BreathType.intake, BreathType.hold, and BreathType.out.
  ///
  /// Prompts do not have to be tied to a breath timing if they are presented to
  /// the user before or after the BreathAnimation is rendered. This is
  /// represented via BreathType.none.
  ///
  /// A prompt may also indicate that the BreathAnimation should be turned on or
  /// off, which is represented via BreathType.toggle.
  ///
  /// Prompts are only available within the context of an Exercise. Even if the
  /// content of a Prompt is identical, Prompts are never reused or referenced
  /// across multiple Exercises.
  const Prompt({required this.type, required this.content});

  /// Creates a placeholder prompt that indicates that the breath animation
  /// should be toggling on or off as a result of encountering this Prompt
  Prompt.breathToggle({this.type = BreathType.toggle, this.content = ''});

  /// Calculates the amount of time this particular prompt should be on screen
  /// when a user is going through an exercise.
  ///
  /// There are two aspects taken into consideration when calculating the
  /// length of a prompt:
  ///   - the reading speed of the user
  ///   - what type of breath this prompt is tied to, if any
  ///
  /// We will always ensure that a user has enough time to read a prompt, based
  /// on their specified reading speed. If a particular prompt will not be
  /// readable in the amount of time the breath provides, we will add additional
  /// full breaths until the entire prompt is readable. This is rare.
  ///
  /// In most cases, the time to read a prompt is less than the amount defined
  /// by the breath type.
  int getLengthInSeconds(UserPreferences preferences) {
    final fullBreath = preferences.inBreathInSeconds +
        preferences.outBreathInSeconds +
        preferences.holdBreathInSeconds +
        preferences.paddingInSeconds;

    final secondsToRead =
        _calculateTimeToRead(content, preferences.calculateSecondsPerWord());
    final int breathsToRead = (secondsToRead / fullBreath).ceil();

    switch (type) {
      case BreathType.full:
        return breathsToRead * fullBreath;

      case BreathType.intake:
        return secondsToRead > preferences.inBreathInSeconds
            ? breathsToRead * fullBreath
            : preferences.inBreathInSeconds;

      case BreathType.hold:
        return secondsToRead > preferences.holdBreathInSeconds
            ? breathsToRead * fullBreath
            : preferences.holdBreathInSeconds;

      case BreathType.out:
        return secondsToRead > preferences.outBreathInSeconds
            ? breathsToRead * fullBreath
            : preferences.outBreathInSeconds + preferences.paddingInSeconds;

      case BreathType.none:
        return secondsToRead + preferences.paddingInSeconds;

      default:
        return 0;
    }
  }

  /// Internal method to map the specific reading speed specified by the user
  /// to the actual time it takes the user to read through the entire prompt
  int _calculateTimeToRead(String prompt, double readingSpeedInSecondsPerWord) {
    const int secondsForBreak = 1;
    final words = splitIntoWords();

    num totalSeconds = 0;
    for (var w in words) {
      totalSeconds +=
          (w == '¶' ? secondsForBreak : readingSpeedInSecondsPerWord);
    }

    return totalSeconds.ceil();
  }

  /// Splits up this prompt into its constituent words in order to render the
  /// word-by-word scrolling in an active exercise, as well as to calculate
  /// reading-speed based timing. A "word" in this function is defined as any
  /// discrete string separated by a spacing character (e.g. spaces, tabs)
  ///
  /// If this prompt contains any punctuation that would cause a natural pause in
  /// conversation, this function also handles inserting a '¶' word after the
  /// relevant word with that punctuation. This is then used by both the render
  /// and the timing functions to add in some additional respective spacing.
  ///
  /// This function assumes that the prompt is a non-null string. If the provided
  /// prompt is empty,
  List<String> splitIntoWords() {
    final RegExp whitespace = RegExp(r'\s+');
    final RegExp lineBreak = RegExp(r'[.!;:?]$');

    final List<String> words = content.trim().split(whitespace);

    final List<String> out = [];
    for (var w in words) {
      final word = w.trim();
      if (word.isEmpty) {
        continue;
      }
      out.add(word);
      if (lineBreak.hasMatch(word)) {
        out.add('¶');
      }
    }

    if (out.isNotEmpty && out.last == '¶') {
      out.removeLast();
    }

    return out;
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'type': type.name};
  }

  factory Prompt.fromJson(Map<String, dynamic> prompt) {
    return Prompt(
        content: prompt['content'],
        type: enumValueFromJson(BreathType.values, prompt['type'])!);
  }
}

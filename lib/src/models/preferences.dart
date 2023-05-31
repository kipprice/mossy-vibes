// enum BreathType { intake, hold, }
import 'package:mossy_vibes/src/models/prompt.dart';

import '../utils/constants.dart';
import 'breath_pattern.dart';
import 'completion_audit.dart';

class UserPreferences {
  /// How quickly the user wants to see words light up.
  int readingSpeedInWpm = 150;

  /// The pattern in which the user wants to breathe
  BreathPattern breathPattern = BreathPattern.calm;

  /// Which exercises this user has flagged as their favorites.
  List<String> favorites = [];

  /// The exercises that the user has completed, as represented through a series
  /// of completion audit entries
  List<CompletionAudit> completedExercises = [];

  /// Creates a set of preferences that will be tied to this specific device.
  ///
  /// By design, preferences are only stored locally. This allows us to not
  /// require a login step, and will for most users be totally fine. If a user
  /// is working across two different devices, we may end up needing to create
  /// a syncing mechanism -- maybe a unique code with the preferences encoded,
  /// or a unique code per device that can be linked together
  UserPreferences({
    this.breathPattern = BreathPattern.calm,
    this.completedExercises = const [],
    this.readingSpeedInWpm = 150,
    this.favorites = const [],
  });

  /// How long the "in" part of the user's breath pattern is
  int get inBreathInSeconds => breathPattern.intake;

  /// How long the "hold" part of the user's breath pattern is
  int get holdBreathInSeconds => breathPattern.hold;

  /// How long the "out" part of the user's breath pattern is
  int get outBreathInSeconds => breathPattern.out;

  /// How long the user's breath pattern waits between breaths
  int get paddingInSeconds => breathPattern.padding;

  /// Determines how long a single breath (in-hold-out-padding) takes, given the
  /// user's current breath pattern
  int calculateFullBreathInSeconds() {
    return inBreathInSeconds +
        outBreathInSeconds +
        holdBreathInSeconds +
        paddingInSeconds;
  }

  /// Determines how long proportionally a particular part of a breath cycle
  /// takes.
  ///
  /// This is used by the BreathAnimation to ensure the timing of each phase
  /// lines up with the actual breath counts.
  double calculateBreathRatio(BreathType type) {
    switch (type) {
      case BreathType.intake:
        return 1.0 * inBreathInSeconds / calculateFullBreathInSeconds();
      case BreathType.hold:
        return 1.0 * holdBreathInSeconds / calculateFullBreathInSeconds();
      case BreathType.out:
        return 1.0 * outBreathInSeconds / calculateFullBreathInSeconds();
      default:
        return 0;
    }
  }

  /// Determines how long proportionally the space between breaths takes.
  ///
  /// This is used by the BreathAnimation to ensure the timing of each phase
  /// lines up with the actual breath counts.
  double calculatePaddingRatio() {
    return paddingInSeconds / calculateFullBreathInSeconds();
  }

  /// Determines how many seconds a single word takes, given the user's current
  /// reading speed.
  double calculateSecondsPerWord() {
    return 1.0 / (readingSpeedInWpm / secondsPerMinute);
  }

  /// Parses a JSON representation of preferences and adds them to the current
  /// model.
  ///
  /// This does not require any data from the JSON model to actually be set, as
  /// all defaults on UserPreferences will still be represented.
  void parseJson(Map<String, dynamic> json) {
    if (json['readingSpeedInWpm'] != null) {
      readingSpeedInWpm = json['readingSpeedInWpm'];
    }

    if (json['breathPattern'] != null) {
      breathPattern = BreathPattern.values
          .firstWhere((element) => element.name == json['breathPattern']);
    }

    if (json['favorites'] != null) {
      favorites = List<String>.from(json['favorites']);
    }

    if (json['completedExercises'] != null) {
      completedExercises = List<CompletionAudit>.from(
          json['completedExercises'].map((a) => CompletionAudit.fromJson(a)));
    }
  }

  /// Translates this model into a JSON representation.
  ///
  /// We use `toJson` to serialize the user's preferences in order to store
  /// them locally. We never work with the JSON representation directly, except
  /// to translate it back into the model.
  Map<String, dynamic> toJson() {
    return {
      'readingSpeedInWpm': readingSpeedInWpm,
      'breathPattern': breathPattern.name,
      'favorites': favorites,
      'completedExercises': completedExercises.map((e) => e.toJson()).toList()
    };
  }
}

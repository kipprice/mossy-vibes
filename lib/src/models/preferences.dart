// enum BreathType { intake, hold, }
import 'package:mossy_vibes/src/models/prompt.dart';

import '../utils/constants.dart';

enum BreathPattern {
  quick(intake: 3, hold: 2, out: 3),
  calm(intake: 4, hold: 4, out: 4),
  relaxed(intake: 4, hold: 7, out: 8);

  const BreathPattern(
      {required this.intake, required this.hold, required this.out});

  final int intake;
  final int hold;
  final int out;
  final int padding = 1;
}

class CompletionAudit {
  final String exerciseId;
  final DateTime completedAt;

  const CompletionAudit({required this.exerciseId, required this.completedAt});

  factory CompletionAudit.fromJson(Map<String, dynamic> json) {
    return CompletionAudit(
        exerciseId: json['exerciseId'],
        completedAt: DateTime.parse(json['completedAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'completedAt': completedAt.toIso8601String()
    };
  }
}

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

  UserPreferences(
      {this.breathPattern = BreathPattern.calm,
      this.completedExercises = const [],
      this.readingSpeedInWpm = 150,
      this.favorites = const []});

  /// Instead of storing these separately, the breath pattern keeps track of
  /// the different types of breaths & their length
  int get inBreathInSeconds => breathPattern.intake;
  int get holdBreathInSeconds => breathPattern.hold;
  int get outBreathInSeconds => breathPattern.out;
  int get paddingInSeconds => breathPattern.padding;

  int calculateFullBreathInSeconds() {
    return inBreathInSeconds +
        outBreathInSeconds +
        holdBreathInSeconds +
        paddingInSeconds;
  }

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

  double calculatePaddingRatio() {
    return paddingInSeconds / calculateFullBreathInSeconds();
  }

  double calculateSecondsPerWord() {
    return 1.0 / (readingSpeedInWpm / secondsPerMinute);
  }

  void parseJson(Map<String, dynamic> json) {
    print('json: $json');
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

  Map<String, dynamic> toJson() {
    return {
      'readingSpeedInWpm': readingSpeedInWpm,
      'breathPattern': breathPattern.name,
      'favorites': favorites,
      'completedExercises': completedExercises.map((e) => e.toJson()).toList()
    };
  }
}

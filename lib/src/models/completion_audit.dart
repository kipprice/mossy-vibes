class CompletionAudit {
  /// What exercise this completion audit is tracking
  final String exerciseId;

  /// The instant at which this exercise was completed
  final DateTime completedAt;

  /// The amount of time the user spent in the exercise
  final int lengthOfExerciseInMinutes;

  /// Tracks when a user has completed a particular exercise.
  ///
  /// THe CompletionAudit allows for tracking which exercises a user has gone
  /// through and when. This data can be used to highlight or fade exercises on
  /// the exercise list, document how much time a user has spent in an exercise,
  /// or offer suggestions.
  const CompletionAudit(
      {required this.exerciseId,
      required this.completedAt,
      required this.lengthOfExerciseInMinutes});

  /// Turns a JSON representation of a CompletionAudit into a full model.
  factory CompletionAudit.fromJson(Map<String, dynamic> json) {
    if (json['exerciseId'] == null) {
      throw FormatException(
          'Expected an exercise ID to create a completion audit');
    }
    return CompletionAudit(
        exerciseId: json['exerciseId'],
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'])
            : DateTime.now(),
        lengthOfExerciseInMinutes: json['lengthOfExerciseInMinutes'] ?? 0);
  }

  /// Translates this model into its JSON equivalent
  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'completedAt': completedAt.toIso8601String(),
      'lengthOfExerciseInMinutes': lengthOfExerciseInMinutes
    };
  }
}

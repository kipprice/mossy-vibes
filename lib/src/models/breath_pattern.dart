enum BreathPattern {
  /// the fastest breath pattern
  quick(intake: 3, hold: 2, out: 3),

  /// the default breath pattern
  calm(intake: 4, hold: 4, out: 4),

  /// the ideal breath pattern for getting very relaxed
  relaxed(intake: 4, hold: 7, out: 8);

  /// Tracks how the user prefers to have the breathing animation timed out.
  const BreathPattern({
    required this.intake,
    required this.hold,
    required this.out,
  });

  /// how long the breath in should take, in seconds.
  final int intake;

  /// how long the breath is held, in seconds.
  final int hold;

  /// how long the breath out should take, in seconds.
  final int out;

  /// what gap should be placed between breaths
  ///
  /// This is currently not configurable, but may be in the future
  final int padding = 2;
}

enum ExerciseLength {
  all(min: 0, max: double.infinity),
  underFive(min: 0, max: 5),
  underTen(min: 5, max: 10),
  underFifteen(min: 10, max: 15),
  overFifteen(min: 15, max: double.infinity);

  const ExerciseLength({required this.max, required this.min});

  final double max;
  final double min;

  /// Retrieves the user-friendly name for this particular exercise length.
  String get name {
    switch (this) {
      case ExerciseLength.all:
        return 'All';
      case ExerciseLength.underFive:
        return '< 5 minutes';
      case ExerciseLength.underTen:
        return '5 - 9 minutes';
      case ExerciseLength.underFifteen:
        return '10 - 14 minutes';
      case ExerciseLength.overFifteen:
        return '15+ minutes';
      default:
        return '';
    }
  }
}

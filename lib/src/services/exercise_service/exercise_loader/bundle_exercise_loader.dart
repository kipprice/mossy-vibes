import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../exercise_parser.dart';
import '../../../models/exercise.dart';
import '_exercise_loader.dart';

class BundledExerciseLoader extends ExerciseLoader {
  AssetBundle bundle;

  /// Handles loading an exercise from the asset bundle of this application.
  ///
  /// Mossy Vibes ships with some out of the box meditations. Because these
  /// bundles only get updated when the user updates their mobile app, this
  /// isn't a reliable way to release new content to users. Instead, we always
  /// bundle the latest set of exercises within any given release of the
  /// application, then load from the server any additional new exercises that
  /// have been released.
  BundledExerciseLoader(
      {required super.exerciseId,
      super.type = 'BUNDLED',
      required this.bundle});

  /// Given a particular exercise, loads that exercise from our asset bundle
  @override
  Future<Exercise?> handleLoad() async {
    final file = await bundle.loadString('assets/exercises/$exerciseId.md');
    final parsedExercise = ExerciseParser().parse(exerciseId, file);
    return parsedExercise;
  }

  /// Helper to retrieve all of the IDs that then can be loaded via the loader
  /// itself
  static Future<List<BundledExerciseLoader>> loadList(
      AssetBundle bundle) async {
    final String fileContents =
        await bundle.loadString('assets/exercises/__exercises.json');
    List<dynamic> exerciseList = jsonDecode(fileContents);

    return exerciseList
        .map((e) => BundledExerciseLoader(exerciseId: e, bundle: bundle))
        .toList();
  }
}

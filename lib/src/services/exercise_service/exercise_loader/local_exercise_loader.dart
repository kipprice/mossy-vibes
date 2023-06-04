import 'package:localstorage/localstorage.dart';

import '../../../models/exercise.dart';
import '_exercise_loader.dart';

class LocalExerciseLoader extends ExerciseLoader {
  dynamic jsonRepresentation;

  /// Handles loading an exercise from local storage for this application
  ///
  /// When the app is offline, we load exercises that have not otherwise been
  /// loaded by the bundle loading via a local storage file. This will load in
  /// all exercises that have previously been loaded from the remote endpoint,
  /// since we always store these exercises after loading.
  LocalExerciseLoader(
      {required super.exerciseId,
      super.type = 'LOCAL',
      required this.jsonRepresentation});

  // Retrieve the local storage version of the exercise with the specified ID
  @override
  Future<Exercise?> handleLoad() async {
    return Exercise.fromJson(jsonRepresentation);
  }

  /// Helper to retrieve all of the IDs that then can be loaded via the loader
  /// itself
  static Future<List<LocalExerciseLoader>> loadList() async {
    final LocalStorage storage = LocalStorage(exerciseStorageFile, null, {});
    await storage.ready;

    List<dynamic>? storedExercises = storage.getItem(exerciseStorageKey);
    if (storedExercises == null) {
      return [];
    }

    return storedExercises
        .map((e) =>
            LocalExerciseLoader(exerciseId: e['id'], jsonRepresentation: e))
        .toList();
  }
}

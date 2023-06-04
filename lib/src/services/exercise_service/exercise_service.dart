import 'package:flutter/foundation.dart' as flutter_config;
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

import '../../models/exercise.dart';
import 'exercise_loader/bundle_exercise_loader.dart';
import 'exercise_loader/local_exercise_loader.dart';
import 'exercise_loader/remote_exercise_loader.dart';
import 'loadable_exercise_list.dart';

class ExerciseService {
  final storageFile = 'exercises.json';
  final exercisesKey = 'exercises';

  static final ExerciseService _exerciseLoader = ExerciseService._init();
  ExerciseService._init();

  /// Loads in the exercise files available in Mossy Vibes.
  ///
  /// The loader can load exercises from two different sources; the exercises
  /// built into the application itself, and the online repository with the
  /// most up-to-date exercises available. By default, this loads in both
  /// exercises, using the online-version when an exercise shares a name.
  ///
  /// In addition to loading exercises, this loader helps ensure that exercises
  /// are available when the app is offline.
  factory ExerciseService() {
    return _exerciseLoader;
  }

  /// Reads in all of the markdown files that make up our exercises and
  /// transforms them into Exercises.
  ///
  /// The exercises loaded in this method are then accessible on the global
  /// application state by all Mossy Vibes widgets.
  Future<List<Exercise>> loadAllExercises(AssetBundle bundle) async {
    LoadableExerciseList exerciseList = LoadableExerciseList();

    const isDebug = flutter_config.kDebugMode;

    // remote exercises are almost always the source of truth, we we try to
    // load them first
    exerciseList.addAll(await RemoteExerciseLoader.loadList());

    // next, we retrieve any exercises that have been stored locally. This will
    // include any versions of remote files that have been previously loaded,
    // which are more likely to be up to date than the bundled exercises
    exerciseList.addAll(await LocalExerciseLoader.loadList());

    // in production mode, bundled exercises are the last loaded, but when
    // in debug mode, they're used instead of any of the alternative loading
    // mechanisms. This allows exercise authors to make local edits and changes
    // without running into cache or remote conflict issues
    exerciseList.addAll(await BundledExerciseLoader.loadList(bundle),
        evalFirst: isDebug);

    final out = await exerciseList.exercises;
    _storeLocalExercises(out);
    return out;
  }

  /// Stores exercises loaded from all services back into the local exercises
  /// file.
  ///
  /// Storage is non-blocking operation, and will ensure that any exercises
  /// that have been loaded from the remote endpoint or local bundle are
  /// added to the local file, for future offline use.
  Future<void> _storeLocalExercises(List<Exercise> toStore) async {
    final LocalStorage storage = LocalStorage(storageFile);

    await storage.ready;
    storage.setItem(exercisesKey, toStore.map((ex) => ex.toJson()).toList());
  }
}

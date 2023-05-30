import 'dart:convert';
import 'package:flutter/foundation.dart' as flutter_config;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

import '../models/exercise.dart';
import 'exercise_parser.dart';

const exercises = [
  'first-meditation',
  'micro-presence',
  'love',
  'benefits-of-meditation',
  'breathing-practice',
  'gratitude',
  'mossy-overview',
  'relaxation',
  'self-care',
  'taking-a-moment',
  'waking-up',
  'what-is-mindfulness'
];

const testExercises = ['_test', '_kindness'];

class ExerciseLoader {
  final storageFile = 'exercises.json';
  final exercisesKey = 'exercises';

  static final ExerciseLoader _exerciseLoader = ExerciseLoader._init();
  ExerciseLoader._init();

  /// Loads in the exercise files available in Mossy Vibes.
  ///
  /// The loader can load exercises from two different sources; the exercises
  /// built into the application itself, and the online repository with the
  /// most up-to-date exercises available. By default, this loads in both
  /// exercises, using the online-version when an exercise shares a name.
  ///
  /// In addition to loading exercises, this loader helps ensure that exercises
  /// are available when the app is offline.
  factory ExerciseLoader() {
    return _exerciseLoader;
  }

  /// Reads in all of the markdown files that make up our exercises and
  /// transforms them into Exercises, which are then accessible on the global
  /// application state by all Mossy Vibes widgets.
  Future<List<Exercise>> loadAllExercises(AssetBundle bundle) async {
    Map<String, Exercise> allExercises = {};

    // remote exercises are always considered the most up to date, so retrieve
    // them before all else.
    await _loadRemoteExercises(allExercises);

    // bundled exercises are the next source of truth, and are available
    // offline.
    await _loadBundledExercises(allExercises, bundle);

    // local exercises are the last resort, but ensure that exercises that were
    // retrieved over the network can be retrieved locally.
    await _loadLocalExercises(allExercises);

    // DO NOT wait on the store function, but do save off the local version of
    // exercises every time we reload.
    _storeLocalExercises(allExercises);

    return allExercises.values.toList();
  }

  /// Retrieves all exercises on the GitHub repo for Mossy Vibes.
  ///
  /// Mossy Vibes is intended to generally be an offline application, but we
  /// still want to be able to update the user's local device with the latest
  /// and greatest from the Mossy Vibes server. We've opted to do this through
  /// GitHub to start, since it allows us to query without a ton of auth
  /// overhead. GitHub does have some limiting volume, so if Mossy Vibes ends
  /// up growing beyond a certain scale, we can transition this function to a
  /// more stable endpoint.
  ///
  /// Because there are volume considerations with GitHub, we have built in
  /// backoff handling, in order to ensure we can try a couple of times before
  /// we throw our hands up in the air.
  ///
  /// These exercises, once retrieved, are then stored in local storage to
  /// ensure that if the user later does not have internet access, they can
  /// still retrieve these exercises.
  Future<Map<String, Exercise>> _loadRemoteExercises(
      Map<String, Exercise> out) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    // ensure there's a perceived connection before trying to retrieve exercises
    // from the open endpoint.
    switch (connectivityResult) {
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.wifi:
        try {
          return _loadFromGithub(out);
        } catch (e) {
          return out;
        }

      default:
        return out;
    }
  }

  Future<Map<String, Exercise>> _loadFromGithub(
      Map<String, Exercise> out) async {
    final listUrl = Uri.parse(
        'https://api.github.com/repos/kipprice/mossy-vibes/contents/assets/exercises');

    final listResp = await http.get(listUrl);
    if (listResp.statusCode != 200) {
      return out;
    }

    List<dynamic> listBody = jsonDecode(listResp.body);

    // build up the map that can load the rest of the files
    Map<String, String> fileMap = {};
    for (var fileDetails in listBody) {
      RegExp idRegex = RegExp(r'/([^/]*?).md$');
      RegExpMatch? idMatch =
          idRegex.firstMatch(fileDetails['download_url'] ?? '');
      if (idMatch == null) {
        continue;
      }
      if (idMatch[1] == null) {
        continue;
      }
      if (idMatch[1]!.startsWith('_')) {
        continue;
      }
      fileMap[idMatch[1]!] = fileDetails['download_url'];
    }

    final List<Future<Exercise?>> promises = [];
    fileMap.forEach((id, url) {
      promises.add(Future(() async {
        final resp = await http.get(Uri.parse(url));
        if (resp.statusCode == 200) {
          return ExerciseParser().parse(id, resp.body);
        } else {
          return null;
        }
      }));
    });

    // wait for all of the files to load
    final exerciseResults = await Future.wait(promises);
    for (var ex in exerciseResults) {
      if (ex == null) {
        continue;
      }

      if (ex.prompts.isEmpty) {
        continue;
      }

      out[ex.id] = ex;
    }

    return out;
  }

  /// Loads all exercises that are pre-bundled with the Mossy Vibes app.
  ///
  /// Mossy Vibes ships with some out of the box meditations. Because these
  /// bundles only get updated when the user updates their mobile app, this
  /// isn't a reliable way to release new content to users. Instead, we always
  /// bundle the latest set of exercises within any given release of the
  /// application, then load from the server any additional new exercises that
  /// have been released.
  Future<Map<String, Exercise>> _loadBundledExercises(
      Map<String, Exercise> out, AssetBundle bundle) async {
    for (String exerciseId in exercises) {
      if (out[exerciseId] != null) {
        continue;
      }
      final file = await bundle.loadString('assets/exercises/$exerciseId.md');
      final parsedExercise = ExerciseParser().parse(exerciseId, file);
      out[exerciseId] = parsedExercise;
    }

    // when in non-release mode, test exercises also get added
    if (!flutter_config.kReleaseMode) {
      for (String exerciseId in testExercises) {
        if (out[exerciseId] != null) {
          continue;
        }
        final file = await bundle.loadString('assets/exercises/$exerciseId.md');
        final parsedExercise = ExerciseParser().parse(exerciseId, file);
        out[exerciseId] = parsedExercise;
      }
    }

    return out;
  }

  /// Loads exercise from the local storage exercise file.
  ///
  /// When the app is offline, we load exercises that have not otherwise been
  /// loaded by the bundle loading via a local storage file. This will load in
  /// all exercises that have previously been loaded from the remote endpoint,
  /// since we always store these exercises after loading.
  Future<Map<String, Exercise>> _loadLocalExercises(
      Map<String, Exercise> out) async {
    final LocalStorage storage = LocalStorage(storageFile, null, {});
    await storage.ready;

    List<dynamic>? storedExercises = storage.getItem(exercisesKey);
    if (storedExercises == null) {
      return out;
    }

    for (var ex in storedExercises) {
      final exercise = Exercise.fromJson(ex);
      if (out[exercise.id] != null) {
        continue;
      }
      if (exercise.prompts.isEmpty) {
        continue;
      }
      out[exercise.id] = exercise;
    }

    return out;
  }

  /// Stores exercises loaded from all services back into the local exercises
  /// file.
  ///
  /// Storage is non-blocking operation, and will ensure that any exercises
  /// that have been loaded from the remote endpoint or local bundle are
  /// added to the local file, for future offline use.
  Future<void> _storeLocalExercises(Map<String, Exercise> toStore) async {
    final LocalStorage storage = LocalStorage(storageFile);

    await storage.ready;
    storage.setItem(
        exercisesKey, toStore.values.map((ex) => ex.toJson()).toList());
  }
}

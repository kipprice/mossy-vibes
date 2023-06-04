import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' as app;

import '../../../models/exercise.dart';

const exerciseStorageFile = 'exercises.json';
const exerciseStorageKey = 'exercises';

abstract class ExerciseLoader {
  final String type;
  String exerciseId;
  Exercise? exercise;

  /// Handles loading a particular exercise with the specified exercise ID
  ExerciseLoader({required this.exerciseId, required this.type});

  Future<Exercise?> load() async {
    if (!_shouldLoad()) {
      return null;
    } else {
      final out = await handleLoad();
      if (out != null) {
        if (out.prompts.isNotEmpty) {
          exercise = out;
          return exercise;
        }
      }
    }
    return null;
  }

  @protected
  Future<Exercise?> handleLoad();

  bool _shouldLoad() {
    if (exerciseId[0] == '_') {
      return !app.kReleaseMode;
    } else {
      return true;
    }
  }

  /// Overridable static function for loading the list of files / contexts
  /// that can then be used to generate relevant loaders
  static Future<List<ExerciseLoader>> loadList() async {
    return [];
  }
}

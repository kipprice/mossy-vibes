import 'dart:io';
import 'dart:convert';

/// Simple helper to ensure prebuild setup is complete
///
/// Runs the following steps:
///   - generate splash screen
///   - generate exercise file list for the bundle
Future<void> main(List<String> arguments) async {
  // regenerate the splash screen in case anything has changed
  await Process.run('dart', ['run', 'flutter_native_splash:create']);

  // generate the exercise config file
  await generateExerciseConfigFile();
}

/// Creates a dynamic list of all of the bundled exercises.
///
/// This list is sorted into published and draft status exercises. This will be
/// run automatically upon merge back into the repository, so exercise authors
/// do not need to update anything to get their new exercises displayed.
Future<void> generateExerciseConfigFile() async {
  final exerciseIds = await _loadExercises();
  await _generateFile(exerciseIds);
  // ExerciseBuckets buckets = ExerciseBuckets.fromList(exerciseNames);
  // await generateFile(buckets);
}

/// Loads all exercises that can be included in the bundle for this app
///
/// Loops through all files in the `assets/examples` directory with a markdown
/// suffix, and parses out the file ID for the file
Future<List<String>> _loadExercises() async {
  Directory dir = Directory('./assets/exercises');
  final files = dir.list();

  List<String> out = [];

  await files.forEach((f) {
    RegExp pathSplitter = RegExp(r'.*?/([^/]+?).md');
    RegExpMatch? match = pathSplitter.firstMatch(f.path);
    if (match != null) {
      out.add(match[1]!);
    }
  });

  return out;
}

/// Create a meta file documenting all of the exercises available in the assets
/// folder
Future<void> _generateFile(List<String> exerciseIds) async {
  final f = File('./assets/exercises/__exercises.json');
  final link = f.openWrite(mode: FileMode.write);
  link.write(jsonEncode(exerciseIds));
  link.close();
}

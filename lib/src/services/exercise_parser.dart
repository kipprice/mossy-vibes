import 'package:mossy_vibes/src/models/prompt.dart';

import '../models/exercise.dart';

final exercises = ['_test', 'first-meditation', 'micro-presence', 'love'];

enum LineType { meta, breathToggle, title, prompt }

class ExerciseParser {
  static final ExerciseParser _exerciseParser = ExerciseParser._init();
  ExerciseParser._init();

  /// Takes in a markdown file and converts it to an `Exercise` object.
  ///
  /// The ExerciseParser is a singleton class, exported This class is only accessed
  /// when setting up the global app state, which generally happens at startup,
  /// but can also be the result of a refresh.
  ///
  /// Example:
  /// ```
  /// var fileContents = io.read('file_name.md');
  /// var exercise = exerciseParser.parse('file_name', fileContents);
  /// ```
  factory ExerciseParser() {
    return _exerciseParser;
  }

  /// The actual logic that manages how markdown files get processed into fully
  /// parsed Exercises. Loops through the specified file line-by-line in order
  /// to map each line to its relevant context within an Exercise.
  Exercise parse(String id, String file) {
    final lines = _splitFile(file);
    bool isBreathFocused = false;

    Exercise out = Exercise(id: id, prompts: []);

    for (final line in lines) {
      final type = _getLineType(line.trim());
      switch (type) {
        case LineType.title:
          out.title = _parseTitle(line);
          break;

        case LineType.meta:
          _parseMeta(line, out);
          break;

        case LineType.breathToggle:
          isBreathFocused = !isBreathFocused;
          out.prompts.add(Prompt.breathToggle());
          break;

        default:
          _parsePrompt(line, isBreathFocused, out);
          break;
      }
    }

    for (int pIdx = (out.prompts.length - 1); pIdx >= 0; pIdx -= 1) {
      Prompt p = out.prompts[pIdx];
      if (p.type == BreathType.toggle) {
        out.prompts.removeLast();
        continue;
      } else {
        break;
      }
    }

    return out;
  }

  List<String> _splitFile(String file) {
    return file.split('\n');
  }

  LineType _getLineType(String line) {
    if (line.trim() == '') {
      return LineType.breathToggle;
    }
    if (line[0] == '#') {
      return LineType.title;
    }
    if (line.startsWith('[_meta')) {
      return LineType.meta;
    }
    return LineType.prompt;
  }

  void _parseMeta(String line, Exercise out) {
    RegExp titleRegex = RegExp(r'\[_meta:(.*?)\]:-\s*"(.*?)"');
    RegExpMatch? match = titleRegex.firstMatch(line);

    switch (match![1]) {
      case 'author':
        out.author = match[2] ?? '';
        break;

      case 'tags':
        out.tags = (match[2] ?? '').split(',').map((element) {
          return element.trim();
        }).toList();
        break;

      case 'size':
        out.size = ExerciseSize.values.firstWhere(
            (v) => v.toString() == 'ExerciseSize.${(match[2] ?? 'normal')}');
        break;

      case 'date-added':
        out.dateAdded = DateTime.tryParse(match[2] ?? '');
        break;

      default:
        break;
    }
  }

  String _parseTitle(String line) {
    RegExp titleRegex = RegExp(r'^#\s+(.*?)$');
    RegExpMatch? match = titleRegex.firstMatch(line);
    return match![1] ?? '';
  }

  void _parsePrompt(String line, bool isBreathFocused, Exercise out) {
    final linePieces = line.split('/');

    switch (linePieces.length) {
      // full breath prompt
      case 1:
        out.prompts.add(Prompt(
            content: line,
            type: isBreathFocused ? BreathType.full : BreathType.none));
        break;

      // split breath prompt
      case 3:
        for (var i = 0; i < linePieces.length; i += 1) {
          String line = linePieces[i];
          BreathType type = i == 0
              ? BreathType.intake
              : i == 1
                  ? BreathType.hold
                  : BreathType.out;
          out.prompts.add(Prompt(content: line, type: type));
        }
        break;

      // don't try to support other prompt splits
      default:
        print('WARNING: "$line" is not a valid prompt');
    }
  }
}

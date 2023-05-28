import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  bool withCoverage = arguments.contains('--coverage');
  print('running tests...');
  await runFormattedTests(withCoverage);
  if (withCoverage) {
    print('generating coverage...');
    await generateCoverageHtml();
  }
  print('done');
}

Future<void> runFormattedTests(bool withCoverage) async {
  final process = await Process.start('flutter',
      ['test', '--reporter=github', withCoverage ? '--coverage' : '']);

  var lastHeader = '';
  var lastGroup = '';

  // take in the stdout results from our process and format them in a more
  // consumable way
  process.stdout.transform(utf8.decoder).forEach((line) {
    final testRegex = RegExp(r'(✅|❌).*?([^/]*?)_test.dart:(.*?)\n');
    final match = testRegex.firstMatch(line);

    if (match != null) {
      if (match[2] != lastHeader) {
        printFileHeader(match[2]!);
        lastHeader = match[2] as String;
      }

      // section out groups as well as files
      var localContent = match[3]!;
      var localGroup = getGroup(localContent);
      if (localGroup.isNotEmpty) {
        if (localGroup != lastGroup) {
          printGroupHeader(localGroup);
          lastGroup = localGroup;
        }
        localContent = localContent.replaceFirst(RegExp(r'\(.*?\) '), '');
      }

      // print this line in a nice readable way
      print('${match[1]}$localContent');

      // print the line as is if it doesn't match our expected format (which
      // in most cases means it is context about an error)
    } else if (line.isNotEmpty) {
      print(line);
    }
  });

  // wait for the process to exit before generating coverage
  await process.exitCode;
}

Future<void> generateCoverageHtml() async {
  final process = await Process.start(
      'genhtml', ['coverage/lcov.info', '-o', 'coverage/html']);
  process.stdout.transform(utf8.decoder).forEach((line) {
    print(line);
  });
  await process.exitCode;
}

void printFileHeader(String fileName) {
  print('');
  print('=' * fileName.length);
  print(fileName.toUpperCase());
  print('=' * fileName.length);
  print('');
}

String getGroup(String content) {
  final groupRegex = RegExp(r'\((.*?)\)');
  final groupMatch = groupRegex.firstMatch(content);

  if (groupMatch == null) {
    return '';
  }
  if (groupMatch[1] == null) {
    return '';
  }
  if (groupMatch[1]!.isEmpty) {
    return '';
  }

  return groupMatch[1]!;
}

void printGroupHeader(String groupName) {
  print('');
  print(groupName);
  print('-' * groupName.length);
}

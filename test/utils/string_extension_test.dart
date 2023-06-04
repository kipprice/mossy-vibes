// Import the test package and Counter class
import 'package:mossy_vibes/src/utils/string_extension.dart';
import 'package:test/test.dart';

void main() {
  test('strings are extended with the capability to capitalize', () {
    expect('not capitalized'.capitalize(), 'Not capitalized');
  });
}

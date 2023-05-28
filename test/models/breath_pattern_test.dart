import 'package:mossy_vibes/src/models/breath_pattern.dart';
import 'package:test/test.dart';

void main() {
  test('a BreathPattern has an integer `intake` value', () {
    expect(BreathPattern.calm.intake, isA<int>());
  });

  test('a BreathPattern has an integer `hold` value', () {
    expect(BreathPattern.calm.hold, isA<int>());
  });

  test('a BreathPattern has an integer `out` value', () {
    expect(BreathPattern.calm.out, isA<int>());
  });

  test('a BreathPattern has an integer `padding` value', () {
    expect(BreathPattern.calm.padding, isA<int>());
  });
}

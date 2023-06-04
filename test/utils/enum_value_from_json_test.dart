// Import the test package and Counter class
import 'package:mossy_vibes/src/utils/enum_value_from_json.dart';
import 'package:test/test.dart';

enum TestEnum {
  one,
  two,
  three;
}

void main() {
  test('enum name should be translated into enum value', () {
    final value = enumValueFromJson(TestEnum.values, 'two');

    expect(value, TestEnum.two);
  });

  test('non-enum name should be translated to null', () {
    final value = enumValueFromJson(TestEnum.values, 'other');

    expect(value, null);
  });
}

import 'package:mossy_vibes/src/models/exercise_length.dart';
import 'package:test/test.dart';

void main() {
  group('An ExerciseLength', () {
    test('can retrieve the name of the All type', () {
      expect(ExerciseLength.all.name, isNot('all'));
    });

    test('can retrieve the name of the under-five type', () {
      expect(ExerciseLength.underFive.name, isNot('underFive'));
    });

    test('can retrieve the name of the under-five type', () {
      expect(ExerciseLength.underTen.name, isNot('underTen'));
    });

    test('can retrieve the name of the under-five type', () {
      expect(ExerciseLength.underFifteen.name, isNot('underFifteen'));
    });

    test('can retrieve the name of the under-five type', () {
      expect(ExerciseLength.overFifteen.name, isNot('overFifteen'));
    });
  });
}

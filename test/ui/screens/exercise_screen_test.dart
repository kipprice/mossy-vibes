import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mossy_vibes/_state.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Widget testBuilder(Widget childToTest) {
    return ChangeNotifierProvider(
        create: (BuildContext ctx) {
          final state = MossyVibesState(DefaultAssetBundle.of(ctx));
          state.exercises = [
            Exercise(id: 'test', title: 'Test Exercise', prompts: [])
          ];
          return state;
        },
        child: MaterialApp(home: childToTest));
  }

  group('The ExerciseScreen', () {
    testWidgets('can be rendered', (WidgetTester tester) async {
      await tester.pumpWidget(testBuilder(ExerciseScreen(exerciseId: 'test')));
      await tester.pump(Duration(seconds: 2));
      expect(find.text('Test Exercise'), findsOneWidget);
    });
  });
}

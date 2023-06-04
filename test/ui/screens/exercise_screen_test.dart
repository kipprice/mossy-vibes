import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mossy_vibes/_state.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:mossy_vibes/src/widgets/atoms/cta_button.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/active_exercise.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/complete_buttons.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_screen.dart';
import 'package:provider/provider.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  Widget testBuilder(Widget childToTest) {
    return ChangeNotifierProvider(
        create: (BuildContext ctx) {
          final state = MossyVibesState(DefaultAssetBundle.of(ctx));
          state.exercises = [
            Exercise(id: 'test', title: 'Test Exercise', prompts: [
              Prompt(type: BreathType.toggle, content: ''),
              Prompt(type: BreathType.full, content: 'Single Line'),
              Prompt(type: BreathType.toggle, content: ''),
            ])
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

    testWidgets('can start the exercise', (WidgetTester tester) async {
      // ensures the screen size can support the prompt + animation
      await binding.setSurfaceSize(Size(400, 800));

      await tester.pumpWidget(testBuilder(ExerciseScreen(exerciseId: 'test')));
      await tester.pump(Duration(seconds: 2));
      await tester.tap(find.byType(CTAButton));
      await tester.pump();
      expect(find.byType(ActiveExercise), findsOneWidget);
    });

    testWidgets('can complete the exercise', (WidgetTester tester) async {
      // ensures the screen size can support the prompt + animation
      await binding.setSurfaceSize(Size(400, 800));

      await tester.pumpWidget(testBuilder(ExerciseScreen(exerciseId: 'test')));
      await tester.pump(Duration(seconds: 2));
      await tester.tap(find.byType(CTAButton));
      await tester.pump(Duration(seconds: 14));
      expect(find.byType(CompleteButtons), findsOneWidget);
    });
  });
}

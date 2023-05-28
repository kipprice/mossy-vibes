import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mossy_vibes/_state.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/exercises_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Widget testBuilder(Widget childToTest) {
    return ChangeNotifierProvider(
        create: (BuildContext ctx) =>
            MossyVibesState(DefaultAssetBundle.of(ctx)),
        child: MaterialApp(
          home: childToTest,
        ));
  }

  group('The ExercisesScreen', () {
    testWidgets('can be rendered', (WidgetTester tester) async {
      await tester.pumpWidget(testBuilder(ExercisesScreen()));
      expect(find.textContaining('All Exercises'), findsOneWidget);
      await tester.pump(Duration(seconds: 2));
    });
  });
}

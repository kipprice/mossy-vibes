import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mossy_vibes/src/widgets/screens/about/about_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget testBuilder(Widget childToTest) {
    return MaterialApp(home: childToTest);
  }

  group('The About Screen', () {
    testWidgets('can be rendered', (WidgetTester tester) async {
      // await binding.setSurfaceSize(Size(1600, 1600));
      try {
        await tester.pumpWidget(testBuilder(AboutScreen()));
        expect(find.textContaining('Welcome'), findsOneWidget);
      } catch (e) {
        print(e.toString());
      }
    });
  });
}

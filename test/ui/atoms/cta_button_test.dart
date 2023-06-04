import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mossy_vibes/src/widgets/atoms/cta_button.dart';

void main() {
  Widget testBuilder(Widget childToTest) {
    return MaterialApp(home: childToTest);
  }

  group('A CTA button', () {
    testWidgets('can be rendered', (WidgetTester tester) async {
      await tester.pumpWidget(
          testBuilder(CTAButton(onPressed: () {}, child: Text('My Button'))));
      expect(find.byType(FilledButton), findsOneWidget);
    });
  });
}

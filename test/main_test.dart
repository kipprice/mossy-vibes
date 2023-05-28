// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mossy_vibes/main.dart';
import 'package:mossy_vibes/src/widgets/atoms/cta_button.dart';
import 'package:mossy_vibes/src/widgets/atoms/inline_button.dart';

void main() {
  group('The Mossy Vibes app', () {
    testWidgets('can be rendered', (WidgetTester tester) async {
      await tester.pumpWidget(const MossyVibes());
      expect(find.text('Mossy Vibes'), findsOneWidget);
      expect(find.byType(CTAButton), findsOneWidget);
      expect(find.byType(InlineButton), findsNWidgets(2));
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp({String text = 'test'}) {
    return MaterialApp(
      home: Text(text),
    );
  }

  testWidgets('example test', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp(text: 'my text'));
  });
}

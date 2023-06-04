import 'dart:ui';

import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:test/test.dart';

void main() {
  test('Colors are available', () {
    expect(MossyColors.darkGreen, Color(0xFF136F63));
  });

  test('The font scale is available', () {
    expect(MossyFontSize.md, 18);
  });

  test('The padding scale is available', () {
    expect(MossyPadding.md, 8);
  });
}

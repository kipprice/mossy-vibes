import 'package:flutter/widgets.dart';

class MossyColors {
  static const Color darkGreen = Color(0xFF136F63);
  static const Color darkestGreen = Color(0xFF0F574F);
  static const Color lightGreen = Color(0xFFC2E1B8);
  static const Color lightOrange = Color(0xFFFFAA5A);
  static const Color darkOrange = Color(0xFFFF785A);
  static const Color yellow = Color(0xFFFFD25A);
  static const Color offWhite = Color(0xFFF6F0E4);
  static const Color offBlack = Color(0xFF232220);
  static const Color lightBrown = Color(0xFFB09668);
  static const Color mediumBrown = Color(0xFF594226);
  static const Color darkBrown = Color(0xFF312924);
}

class MossyFontSize {
  static const double sm = 14;
  static const double md = 18;
  static const double lg = 24;
  static const double xl = 36;
  static const double xxl = 48;
}

class MossyPadding {
  static const double xs = 2;
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;
  static const double xl = 32;
  static const double xxl = 64;
}

@Deprecated('use other mossy specific constants instead')
class MossyTheme extends MossyColors {
  static const Color darkGreen = Color(0xFF136F63);
  static const Color lightGreen = Color(0xFFC2E1B8);
  static const Color lightOrange = Color(0xFFFFAA5A);
  static const Color darkOrange = Color(0xFFFF785A);
  static const Color yellow = Color(0xFFFFD25A);
  static const Color offWhite = Color(0xFFF6F0E4);
  static const Color offBlack = Color(0xFF232220);
  static const Color lightBrown = Color(0xFFB09668);
  static const Color mediumBrown = Color(0xFF594226);
  static const Color darkBrown = Color(0xFF312924);

  static const double fontSm = 14;
  static const double fontMd = 18;
  static const double fontLg = 24;
  static const double fontXl = 36;
  static const double font2Xl = 48;

  static const double paddingXs = 2;
  static const double paddingSm = 4;
  static const double paddingMd = 8;
  static const double paddingLg = 16;
  static const double paddingXl = 32;
  static const double padding2Xl = 64;
}

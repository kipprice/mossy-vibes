import 'package:flutter/widgets.dart';

/// Defines the colors used within Mossy Vibes.
///
/// This must be accessed as a static class, for example:
/// ```
/// // This works without issue
/// final staticColor = MossyColors.darkGreen;
///
/// // This will throw an error
/// final instanceColor = MossyColors().darkGreen;
/// ```
class MossyColors {
  /// the primary theme color; used for backgrounds
  static const Color darkGreen = Color(0xFF136F63);

  /// A darker variant of the primary theme color; used for overlays
  static const Color darkestGreen = Color(0xFF0F574F);

  /// the secondary theme color; used for some buttons
  static const Color lightGreen = Color(0xFFC2E1B8);

  /// the tertiary theme color; used as the favorites button.
  static const Color lightOrange = Color(0xFFFFAA5A);

  /// quaternary theme color; not used
  static const Color darkOrange = Color(0xFFFF785A);

  /// quinary theme color; not used
  static const Color yellow = Color(0xFFFFD25A);

  /// the primary foreground color, contrasting with `darkGreen`
  static const Color offWhite = Color(0xFFF6F0E4);

  /// a foreground color for some of the secondary+ colors
  static const Color offBlack = Color(0xFF232220);

  /// an additional color; not used
  static const Color lightBrown = Color(0xFFB09668);

  /// an additional color; not used
  static const Color mediumBrown = Color(0xFF594226);

  /// an additional color; not used
  static const Color darkBrown = Color(0xFF312924);
}

/// The scale we use for fonts within Mossy Vibes
class MossyFontSize {
  /// the smallest font size (14px)
  static const double sm = 14;

  /// the default font size (18px)
  static const double md = 18;

  /// the subheader font sze (24px)
  static const double lg = 24;

  /// the header font size (36px)
  static const double xl = 36;

  /// the headline font size (48px)
  static const double xxl = 48;
}

/// The scale we use for padding and margins within Mossy Vibes
class MossyPadding {
  /// 2px
  static const double xs = 2;

  /// 4px
  static const double sm = 4;

  /// 8px
  static const double md = 8;

  /// 16px
  static const double lg = 16;

  /// 32px
  static const double xl = 32;

  /// 64px
  static const double xxl = 64;
}

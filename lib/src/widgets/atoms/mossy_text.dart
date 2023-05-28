import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mossy_vibes/src/utils/theme.dart';

enum MFontWeight { light, base, bold }

class MText extends StatelessWidget {
  final String content;
  final Color color;
  final double fontSize;
  final MFontWeight fontWeight;
  final double opacity;
  final bool underline;

  MText(this.content,
      {super.key,
      this.color = MossyColors.offWhite,
      this.fontSize = MossyFontSize.md,
      this.fontWeight = MFontWeight.light,
      this.opacity = 1,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: underline
          ? DottedDecoration(
              dash: [2, 3],
              shape: Shape.line,
              linePosition: LinePosition.bottom,
              color: MossyColors.offWhite,
              strokeWidth: 2)
          : null,
      child: Opacity(
        opacity: opacity,
        child: Text(content,
            style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    color: color,
                    fontSize: fontSize,
                    fontWeight: fontWeight == MFontWeight.light
                        ? FontWeight.w400
                        : fontWeight == MFontWeight.bold
                            ? FontWeight.w600
                            : FontWeight.w500))),
      ),
    );
  }
}

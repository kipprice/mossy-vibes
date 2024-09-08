import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../utils/theme.dart';

class InlineButton extends StatelessWidget {
  final void Function()? onPressed;
  final String child;
  final double fontSize;
  final MFontWeight fontWeight;
  final Color color;

  InlineButton(
      {required this.onPressed,
      required this.child,
      this.color = MossyColors.lightGreen,
      this.fontSize = MossyFontSize.md,
      this.fontWeight = MFontWeight.base});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor:
              WidgetStateProperty.resolveWith((states) => MossyColors.offWhite),
          textStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
                fontSize: width > 600 ? MossyFontSize.lg : MossyFontSize.md,
                fontFamily: 'Quicksand',
              )),
          padding: WidgetStateProperty.resolveWith((states) =>
              EdgeInsets.all(width > 600 ? MossyPadding.lg : MossyPadding.sm)),
          overlayColor:
              WidgetStateColor.resolveWith((states) => color.withAlpha(20))),
      child: DecoratedBox(
          decoration: DottedDecoration(
              linePosition: LinePosition.bottom,
              dash: [2, 4],
              strokeWidth: 2,
              color: MossyColors.lightGreen),
          child: MText(
            child,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          )),
    );
  }
}

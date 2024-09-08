import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  SecondaryButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return OutlinedButton(
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
          overlayColor: WidgetStateColor.resolveWith(
              (states) => MossyColors.lightGreen.withAlpha(20))),
      child: child,
    );
  }
}

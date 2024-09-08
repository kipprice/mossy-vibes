import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import 'full_width.dart';

class CTAButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  /// Creates an emphasized button, used to signal which action is recommended.
  CTAButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Color getButtonBg(Set<WidgetState> states) {
      return MossyColors.offWhite;
    }

    Color getButtonFg(Set<WidgetState> states) {
      return MossyColors.darkGreen;
    }

    return FullWidth(
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
            textStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
                fontSize: width > 600 ? MossyFontSize.xl : MossyFontSize.lg,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500)),
            backgroundColor: WidgetStateProperty.resolveWith(getButtonBg),
            foregroundColor: WidgetStateProperty.resolveWith(getButtonFg),
            padding: WidgetStateProperty.resolveWith((states) => EdgeInsets.all(
                width > 600 ? MossyPadding.lg : MossyPadding.md)),
            overlayColor: WidgetStateColor.resolveWith(
                (states) => MossyColors.lightGreen)),
        child: child,
      ),
    );
  }
}

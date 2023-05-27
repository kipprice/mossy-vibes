import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import 'full_width.dart';

class CTAButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  CTAButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Color getButtonBg(Set<MaterialState> states) {
      return MossyColors.offWhite;
    }

    Color getButtonFg(Set<MaterialState> states) {
      return MossyColors.darkGreen;
    }

    return FullWidth(
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                fontSize: width > 600 ? MossyFontSize.xl : MossyFontSize.lg,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500)),
            backgroundColor: MaterialStateProperty.resolveWith(getButtonBg),
            foregroundColor: MaterialStateProperty.resolveWith(getButtonFg),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.all(
                    width > 600 ? MossyPadding.lg : MossyPadding.md)),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => MossyColors.lightGreen)),
        child: child,
      ),
    );
  }
}

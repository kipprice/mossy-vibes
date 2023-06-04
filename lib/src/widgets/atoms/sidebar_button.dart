import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import 'full_width.dart';

class SidebarButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  SidebarButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    Color getButtonFg(Set<MaterialState> states) {
      return MossyColors.offWhite;
    }

    return FullWidth(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                  fontSize: MossyFontSize.lg,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Quicksand',
                )),
            foregroundColor: MaterialStateProperty.resolveWith(getButtonFg),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.all(MossyPadding.md)),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => MossyColors.offWhite.withAlpha(40))),
        child: child,
      ),
    );
  }
}

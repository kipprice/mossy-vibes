import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../utils/theme.dart';
import 'full_width.dart';

class SidebarButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  SidebarButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    Color getButtonFg(Set<MaterialState> states) {
      return MossyTheme.offWhite;
    }

    MossyVibesState appState = context.watch<MossyVibesState>();
    return FullWidth(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                  fontSize: MossyTheme.fontLg,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Quicksand',
                )),
            foregroundColor: MaterialStateProperty.resolveWith(getButtonFg),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.all(MossyTheme.paddingMd)),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => MossyTheme.offWhite.withAlpha(40))),
        child: child,
      ),
    );
  }
}

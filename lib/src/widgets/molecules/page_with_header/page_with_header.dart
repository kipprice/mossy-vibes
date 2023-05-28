import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../../utils/theme.dart';
import 'drawer.dart';

class MossyPageWithHeader extends StatelessWidget {
  final String title;
  final Widget body;
  final double padding;

  MossyPageWithHeader(
      {required this.title,
      required this.body,
      this.padding = MossyPadding.md});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: MText(
            title,
            fontSize: MossyFontSize.lg,
            fontWeight: MFontWeight.base,
          ),
          foregroundColor: MossyColors.offWhite,
          backgroundColor: MossyColors.offBlack.withAlpha(20),
          centerTitle: true,
        ),
        endDrawer: Drawer(
            backgroundColor: MossyColors.darkGreen,
            width: min(width * 0.85, 600),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MossyPadding.md)),
            child: MossyDrawer()),
        body: SafeArea(
            child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: body,
            ),
          ),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../../utils/theme.dart';
import '../../atoms/sidebar_button.dart';
import '../share_links/share_links.dart';

class MossyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(MossyPadding.lg),
      child: Column(children: [
        SizedBox(height: MossyPadding.lg),
        Row(
          children: [
            Expanded(
                child: SidebarButton(
                    onPressed: () {
                      context.go('/');
                      Navigator.of(context).pop();
                    },
                    child: MText(
                      'Home',
                      fontSize: MossyFontSize.lg,
                      fontWeight: MFontWeight.bold,
                    ))),
          ],
        ),
        SizedBox(height: MossyPadding.lg),
        SidebarButton(
            onPressed: () {
              context.go('/exercises');
              Navigator.of(context).pop();
            },
            child: MText(
              'Exercises',
              fontSize: MossyFontSize.lg,
              fontWeight: MFontWeight.bold,
            )),
        SizedBox(height: MossyPadding.lg),
        SidebarButton(
            onPressed: () {
              context.go('/settings');
              Navigator.of(context).pop();
            },
            child: MText(
              'Settings',
              fontSize: MossyFontSize.lg,
              fontWeight: MFontWeight.bold,
            )),
        SizedBox(height: MossyPadding.xxl),
        SidebarButton(
            onPressed: () {
              context.go('/about');
              Navigator.of(context).pop();
            },
            child: MText(
              'About Mossy Vibes',
              fontSize: MossyFontSize.lg,
              fontWeight: MFontWeight.bold,
            )),
        SizedBox(height: MossyPadding.xxl),
        SizedBox(height: MossyPadding.md),
        ShareLinks(
          inSidebar: true,
        )
      ]),
    ));
  }
}

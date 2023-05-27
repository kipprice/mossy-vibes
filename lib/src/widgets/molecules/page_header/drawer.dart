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
      padding: EdgeInsets.all(MossyTheme.paddingLg),
      child: Column(children: [
        SizedBox(height: MossyTheme.paddingLg),
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
        SizedBox(height: MossyTheme.paddingLg),
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
        SizedBox(height: MossyTheme.paddingLg),
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
        SizedBox(height: MossyTheme.padding2Xl),
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
        SizedBox(height: MossyTheme.padding2Xl),
        SizedBox(height: MossyTheme.paddingMd),
        ShareLinks(
          inSidebar: true,
        )
      ]),
    ));
  }
}

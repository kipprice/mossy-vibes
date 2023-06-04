import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mossy_vibes/src/services/analytics_service.dart';
import 'package:mossy_vibes/src/widgets/molecules/share_links/generate_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/theme.dart';
import 'share_section.dart';

class ShareLinks extends StatelessWidget {
  final bool inSidebar;

  ShareLinks({this.inSidebar = false});

  @override
  Widget build(BuildContext context) {
    final bmcLogo = SvgPicture.asset(
      'assets/svg/bmc-logo.svg',
      semanticsLabel: 'Buy Me a Coffee Logo',
      height: 24,
      width: 24,
    );

    final links = generateShareLinks();

    final width = MediaQuery.of(context).size.width * (inSidebar ? 0.7 : 1);

    return Flex(
      direction: width > 400 ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShareSection(title: 'Our Info', children: [
          IconButton(
              onPressed: () {
                launchUrl(links.mossyEmail!);
              },
              icon: Icon(
                FeatherIcons.mail,
                color: MossyColors.offWhite,
                size: 24,
              )),
          IconButton(
              onPressed: () {
                launchUrl(links.mossyInstagram!);
              },
              icon: Icon(
                FeatherIcons.instagram,
                color: MossyColors.offWhite,
              )),
        ]),
        SizedBox(
          height: MossyPadding.lg,
          width: MossyPadding.xl,
        ),
        ShareSection(title: 'Share', children: [
          IconButton(
              onPressed: () {
                launchUrl(links.email!);
              },
              icon: Icon(
                FeatherIcons.mail,
                color: MossyColors.offWhite,
              )),
          IconButton(
              onPressed: () {
                launchUrl(links.facebook!);
              },
              icon: Icon(
                FeatherIcons.facebook,
                color: MossyColors.offWhite,
              )),
          IconButton(
              onPressed: () {
                launchUrl(links.twitter!);
              },
              icon: Icon(
                FeatherIcons.twitter,
                color: MossyColors.offWhite,
              )),
        ]),
        SizedBox(
          height: MossyPadding.lg,
          width: MossyPadding.xl,
        ),
        ShareSection(title: 'Donate', children: [
          IconButton(
              onPressed: () {
                AnalyticsService().track(AnalyticsEventType.donateClicked);
                launchUrl(links.donate!);
              },
              icon: bmcLogo)
        ]),
      ],
    );
  }
}

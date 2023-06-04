import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/widgets/screens/about/privacy/privacy_section.dart';

import '../../../utils/theme.dart';
import '../../atoms/mossy_text.dart';
import '../../molecules/mossy_log.dart';
import '../../molecules/page_with_header/page_with_header.dart';
import '../../molecules/share_links/share_links.dart';

class AboutScreen extends StatelessWidget {
  /// Renders high level details about Mossy Vibes.
  ///
  /// This screen is purposefully pretty sparse, containing just the basic
  /// details about Mossy Vibes and its creators (us!).
  AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MossyPageWithHeader(
      title: 'About Mossy Vibes',
      body: Stack(children: [
        ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MossyPadding.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MText('Welcome to Mossy Vibes!'),
                SizedBox(height: MossyPadding.lg),
                MText(
                    'We created Mossy Vibes as a way to make it easier to find meditative and mindful moments, no matter where you are mentally or physically. The exercises are short, and designed to be read rather than listened to; and every day, we try to add a new one!'),
                SizedBox(height: MossyPadding.lg),
                //OLD TEXT:
                SizedBox(height: MossyPadding.lg),
                MText(
                  'If you enjoy using Mossy Vibes and want to help us keep it going, we appreciate any support you are able to give!',
                ),
              ],
            ),
          ),
          SizedBox(height: MossyPadding.xl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MossyPadding.md),
            child: ShareLinks(),
          ),
          SizedBox(height: MossyPadding.xl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MossyPadding.lg),
            child: PrivacySection(),
          ),
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MossyPadding.xxl),
              child: MossyLog(opacity: 0.5),
            ),
          ],
        )
      ]),
    );
  }
}

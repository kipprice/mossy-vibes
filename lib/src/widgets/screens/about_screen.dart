import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import '../atoms/mossy_text.dart';
import '../molecules/mossy_log.dart';
import '../molecules/page_with_header/page_with_header.dart';
import '../molecules/share_links/share_links.dart';

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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MossyPadding.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText('Welcome to Mossy Vibes!'),
              SizedBox(height: MossyPadding.lg),
              MText(
                'We created Mossy Vibes as a way to make it easier to find meditative and mindful moments, no matter where you are mentally or physically. The exercises are short, and designed to be read rather than listened to; and every day, we try to add a new one!',
              ),
              SizedBox(height: MossyPadding.lg),
              MText(
                'We don\'t track any of your data, but we do store your preferences directly on your device. This information is only visible to you.',
              ),
              SizedBox(height: MossyPadding.lg),
              MText(
                'If you enjoy using Mossy Vibes and want to help us keep it going, we appreciate any support you are able to give!',
              ),
            ],
          ),
        ),
        SizedBox(height: MossyPadding.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MossyPadding.md),
          child: ShareLinks(),
        ),
        Expanded(
          child: SizedBox(
            height: MossyPadding.xxl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MossyPadding.xxl),
          child: MossyLog(),
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/widgets/atoms/inline_button.dart';

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
                  'We created Mossy Vibes as a way to make it easier to find meditative and mindful moments, no matter where you are mentally or physically. The exercises are short, and designed to be read rather than listened to; and every day, we try to add a new one!'),
              SizedBox(height: MossyPadding.lg),
              MText(
                'We collect anonymous information to help us improve, but never any of your personal information.',
              ),
              InlineButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: MossyColors.darkGreen,
                        builder: (context) {
                          return SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(MossyPadding.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MText(
                                    'Data Just Visible To You',
                                    fontWeight: MFontWeight.bold,
                                  ),
                                  MText(
                                      'Your settings, favorites, and exercise history are only stored on the device you\'re using Mossy Vibes on. The Mossy Vibes team has no access to this data.'),
                                  SizedBox(
                                    height: MossyPadding.lg,
                                  ),
                                  MText(
                                    'Data Collected by Mossy Vibes',
                                    fontWeight: MFontWeight.bold,
                                  ),
                                  MText(
                                      'We collect anonymous information about how people are using Mossy Vibes, in order to help us fix bugs and improve the application. This data includes what browser or operating system is being used, which exercises have a lot of users, and whether our setting defaults are working for most people. This information never contains anything specifially related to you.'),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MossyPadding.sm),
                    child: MText(
                      'Learn More',
                      fontSize: MossyFontSize.sm,
                    ),
                  )),
              //OLD TEXT:
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

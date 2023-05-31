import 'package:flutter/material.dart';

import '../../../../utils/theme.dart';
import '../../../atoms/mossy_text.dart';

class PrivacyDetails extends StatelessWidget {
  const PrivacyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MossyPadding.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                'We collect anonymous information about how people are using Mossy Vibes, in order to help us fix bugs and improve the application. This information never contains anything specifially related to you.'),
          ],
        ),
      ),
    );
  }
}

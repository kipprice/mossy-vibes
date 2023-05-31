import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/services/analytics_service.dart';
import 'package:mossy_vibes/src/widgets/atoms/inline_button.dart';
import 'package:mossy_vibes/src/widgets/screens/about/privacy/privacy_details.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../utils/theme.dart';
import '../../../atoms/secondary_button.dart';
import '../../../atoms/mossy_text.dart';

class PrivacySection extends StatefulWidget {
  const PrivacySection({super.key});

  @override
  State<PrivacySection> createState() => _PrivacySectionState();
}

class _PrivacySectionState extends State<PrivacySection> {
  bool? analyticsDisabled;

  @override
  void initState() {
    _initAnalyticsDisabled();
    super.initState();
  }

  Future<void> _initAnalyticsDisabled() async {
    final tmpAnalyticsDisabled = await AnalyticsService().analyticsDisabled;
    setState(() {
      analyticsDisabled = tmpAnalyticsDisabled;
    });
  }

  Future<void> toggleCollectionOfAnalytics(bool disableAnalytics) async {
    await AnalyticsService().toggleCollectionOfAnalytics(disableAnalytics);
    final tmpAnalyticsDisabled = await AnalyticsService().analyticsDisabled;
    print('analytics status: $tmpAnalyticsDisabled');
    setState(() {
      analyticsDisabled = tmpAnalyticsDisabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MText(
        'Privacy Policy',
        fontWeight: MFontWeight.bold,
      ),
      MText(
        'We collect anonymous analytics to help us improve, but never any of your personal information.',
      ),
      Row(children: [
        InlineButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: MossyColors.darkestGreen,
                builder: (context) {
                  return PrivacyDetails();
                });
          },
          child: 'Learn More',
        ),
        Expanded(
          child: SizedBox(
            width: MossyPadding.lg,
          ),
        ),
        analyticsDisabled == null
            ? MText('Loading')
            : Row(
                children: [
                  MText(
                    'Disable analytics',
                    color: MossyColors.lightGreen,
                    fontWeight: MFontWeight.base,
                  ),
                  SizedBox(
                    width: MossyPadding.md,
                  ),
                  Switch(
                      thumbColor: MaterialStateProperty.resolveWith(
                          (states) => MossyColors.lightGreen),
                      trackOutlineColor: MaterialStateProperty.resolveWith(
                          (states) => MossyColors.lightGreen),
                      activeTrackColor: MossyColors.lightGreen.withAlpha(150),
                      value: analyticsDisabled!,
                      onChanged: toggleCollectionOfAnalytics),
                ],
              )
        // ),
      ])
    ]);
  }
}

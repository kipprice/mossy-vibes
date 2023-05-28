import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/screens/settings/breath_pattern_field.dart';
import 'package:mossy_vibes/src/widgets/screens/settings/reading_speed_field.dart';

import '../../molecules/mossy_log.dart';
import '../../molecules/page_with_header/page_with_header.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MossyPageWithHeader(
      title: 'Settings',
      body: Container(
        padding: EdgeInsets.all(MossyPadding.md),
        child: Column(
          children: [
            Form(
                child: Column(children: [
              ReadingSpeedField(),
              SizedBox(height: MossyPadding.lg),
              BreathPatternField()
            ])),
            Expanded(
              child: SizedBox(
                height: MossyPadding.xxl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MossyPadding.xxl),
              child: MossyLog(),
            )
          ],
        ),
      ),
    );
  }
}

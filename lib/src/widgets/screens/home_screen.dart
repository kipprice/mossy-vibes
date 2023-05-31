import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:mossy_vibes/src/widgets/molecules/mossy_log.dart';

import '../../utils/theme.dart';
import '../atoms/cta_button.dart';
import '../atoms/secondary_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MossyPadding.lg),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 10,
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(children: [
                        MText(
                          'Welcome to',
                          fontSize: MossyFontSize.xl,
                          fontWeight: MFontWeight.light,
                        ),
                        MText(
                          'Mossy Vibes',
                          fontSize: MossyFontSize.xl,
                          fontWeight: MFontWeight.bold,
                        ),
                        SizedBox(height: MossyPadding.xl),
                        CTAButton(
                            onPressed: () {
                              context.go('/exercises');
                            },
                            child: MText('Get Started',
                                fontSize: MossyFontSize.lg,
                                fontWeight: MFontWeight.bold,
                                color: MossyColors.darkGreen)),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width > 600 ? 0 : MossyPadding.lg,
                              vertical: width > 600
                                  ? MossyPadding.xl
                                  : MossyPadding.lg),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SecondaryButton(
                                      onPressed: () {
                                        context.go('/settings');
                                      },
                                      child: MText(
                                        'Settings',
                                        fontWeight: MFontWeight.base,
                                      )),
                                ),
                                SizedBox(
                                  width: MossyPadding.lg,
                                ),
                                Expanded(
                                  child: SecondaryButton(
                                      onPressed: () {
                                        context.go('/about');
                                      },
                                      child: MText(
                                        'About',
                                        fontWeight: MFontWeight.base,
                                      )),
                                )
                              ]),
                        ),
                      ])
                    ],
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 10,
                  )),
                  MossyLog(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

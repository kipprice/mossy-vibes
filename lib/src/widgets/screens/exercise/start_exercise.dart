import 'package:flutter/widgets.dart';
import 'package:mossy_vibes/main.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/cta_button.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

class StartExercise extends StatelessWidget {
  final Exercise exercise;
  final void Function() onStart;

  StartExercise({required this.exercise, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MossyVibesState>();
    final preferences = appState.preferences;

    final lengthInMinutes = exercise.getLengthInMinutes(preferences);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MossyPadding.lg),
        Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
          MText('Written by'),
          SizedBox(width: MossyPadding.sm),
          MText(
            '${exercise.author}',
            fontWeight: MFontWeight.base,
          )
        ]),
        SizedBox(height: MossyPadding.sm),
        MText(
          '$lengthInMinutes minute${lengthInMinutes == 1 ? '' : 's'}',
          fontSize: MossyFontSize.xl,
        ),
        SizedBox(height: MossyPadding.lg),
        Wrap(
          children: [
            for (var tag in exercise.tags ?? [])
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: MossyPadding.sm,
                          horizontal: MossyPadding.lg),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(MossyPadding.xxl),
                          color: MossyColors.lightGreen.withAlpha(30)),
                      child: MText('#$tag')),
                  SizedBox(
                    width: 10,
                  )
                ],
              )
          ],
        ),
        SizedBox(
          height: MossyPadding.xxl,
        ),
        Padding(
          padding: const EdgeInsets.all(MossyPadding.xl),
          child: CTAButton(
              onPressed: () {
                onStart();
              },
              child: MText(
                'Begin',
                fontWeight: MFontWeight.bold,
                fontSize: MossyFontSize.lg,
                color: MossyColors.darkGreen,
              )),
        )
      ],
    );
  }
}

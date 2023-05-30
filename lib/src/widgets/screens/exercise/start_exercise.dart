import 'package:flutter/widgets.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/cta_button.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

import '../../../../_state.dart';
import 'exercise_state.dart';

class StartExercise extends StatelessWidget {
  /// Renders the exercise details and "Start Exercise" button to the user.
  ///
  /// The StartExercise screen only ever appears when the user is coming from
  /// the ExercisesScreen; when restarting an exercise, the exercise is
  /// immediately re-rendered on the starting prompt.
  StartExercise({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MossyVibesState>();
    final preferences = appState.preferences;

    final exerciseState = ExerciseContext.of(context);
    final exercise = exerciseState.exercise;

    final lengthInMinutes =
        exerciseState.exercise.getLengthInMinutes(preferences);

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
              onPressed: exerciseState.onStart,
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

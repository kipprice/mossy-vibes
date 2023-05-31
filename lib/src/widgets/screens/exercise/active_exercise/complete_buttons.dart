import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/atoms/animate_fade.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../../../utils/theme.dart';
import '../../../atoms/secondary_button.dart';
import '../exercise_state.dart';

class CompleteButtons extends StatelessWidget {
  const CompleteButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseState = ExerciseContext.of(context);
    bool isComplete = exerciseState.isComplete;

    return AnimateFadeAndRemove(
      isVisible: isComplete,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MossyPadding.xl),
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                  onPressed: () {
                    context.go('/exercises');
                  },
                  child: MText(
                    'Back to Exercises',
                    fontWeight: MFontWeight.base,
                  )),
            ),
            SizedBox(width: MossyPadding.lg),
            Expanded(
                child: SecondaryButton(
                    onPressed: exerciseState.onReset,
                    child: MText(
                      'Restart',
                      fontWeight: MFontWeight.base,
                    )))
          ],
        ),
      ),
    );
  }
}

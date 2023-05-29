import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/word_scroller.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_state.dart';

import '../../../atoms/animate_fade.dart';

class PromptFader extends StatelessWidget {
  final int promptIdx;

  const PromptFader({
    super.key,
    required this.promptIdx,
  });
  @override
  Widget build(BuildContext context) {
    final exerciseState = ExerciseContext.of(context);
    final exercise = exerciseState.exercise;
    final currentPromptIdx = exerciseState.currentPromptIdx;

    const fadeLength = 300;

    return AnimateFadeAndRemove(
      key: Key('animated-prompt-$promptIdx'),
      duration: fadeLength,
      delayIn: fadeLength,
      isVisible: promptIdx == currentPromptIdx,
      child: WordScroller(
          key: Key('word-scroller-${exercise.id}-$promptIdx'),
          promptIdx: promptIdx,
          delayBy: fadeLength),
    );
  }
}

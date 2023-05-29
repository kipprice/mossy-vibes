import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/prompt_fader.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_state.dart';
import 'package:provider/provider.dart';

import '../../../../../_state.dart';
import '../../../../models/exercise.dart';
import '../../../../models/prompt.dart';

class PromptScroller extends StatefulWidget {
  const PromptScroller({
    super.key,
  });

  @override
  State<PromptScroller> createState() => _PromptScrollerState();
}

class _PromptScrollerState extends State<PromptScroller> {
  Timer? _nextTimer;

  @override
  void dispose() {
    _nextTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    final exerciseState = ExerciseContext.of(context);
    final exercise = exerciseState.exercise;
    final isComplete = exerciseState.isComplete;

    Prompt prompt = exerciseState.currentPrompt;

    int promptLength = prompt.getLengthInSeconds(appState.preferences);

    if (!isComplete) {
      _nextTimer = Timer(Duration(seconds: promptLength), () {
        exerciseState.onNext();
      });
    }

    return Padding(
      padding: const EdgeInsets.all(MossyPadding.md),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        for (var pIdx = 0; pIdx < exercise.prompts.length; pIdx += 1)
          PromptFader(promptIdx: pIdx)
      ]),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/animate_fade.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/word_scroller.dart';
import 'package:provider/provider.dart';

import '../../../../../_state.dart';
import '../../../../models/exercise.dart';
import '../../../../models/prompt.dart';

class PromptScroller extends StatefulWidget {
  final int currentPromptIdx;
  final void Function() onNext;
  final Exercise exercise;
  final bool isComplete;

  const PromptScroller(
      {super.key,
      required this.currentPromptIdx,
      required this.exercise,
      required this.onNext,
      required this.isComplete});

  @override
  State<PromptScroller> createState() => _PromptScrollerState();
}

class _PromptScrollerState extends State<PromptScroller> {
  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();
    Prompt prompt = widget.exercise.prompts[widget.currentPromptIdx];

    int promptLength = prompt.getLengthInSeconds(appState.preferences);

    if (!widget.isComplete) {
      Timer(Duration(seconds: promptLength), () {
        widget.onNext();
      });
    }

    return Padding(
      padding: const EdgeInsets.all(MossyPadding.md),
      child: Stack(alignment: Alignment.center, children: [
        for (var pIdx = 0; pIdx < widget.exercise.prompts.length; pIdx += 1)
          AnimateFadeAndRemove(
            isVisible: pIdx == widget.currentPromptIdx,
            child: WordScroller(
                key: Key('word-scroller-${widget.currentPromptIdx}'),
                currentPromptIdx: widget.currentPromptIdx,
                onNext: widget.onNext,
                exercise: widget.exercise),
          ),
      ]),
    );
  }
}

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

import '../../../../../_state.dart';
import '../../../../models/exercise.dart';
import '../../../../models/prompt.dart';

/// WordScroller highlights the text in an exercise one-by-one, in order to
/// help the user stay focused on the application.
class WordScroller extends StatefulWidget {
  final int currentPromptIdx;
  final void Function() onNext;
  final Exercise exercise;

  /// Handles fading words in and out at the reading speed the user has elected
  /// for.
  WordScroller({
    super.key,
    required this.currentPromptIdx,
    required this.onNext,
    required this.exercise,
  });

  @override
  State<WordScroller> createState() => _WordScrollerState();
}

class _WordScrollerState extends State<WordScroller> {
  int wordIdx = 0;
  Timer? _wordTimer;

  @override
  void initState() {
    wordIdx = 0;
    super.initState();
  }

  @override
  void dispose() {
    _wordTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();
    Prompt prompt = widget.exercise.prompts[widget.currentPromptIdx];
    List<String> words = prompt.splitIntoWords();

    if (wordIdx < words.length - 1) {
      final delayInSeconds = words[wordIdx] == '¶'
          ? 1
          : appState.preferences.calculateSecondsPerWord();
      _wordTimer =
          Timer(Duration(milliseconds: (delayInSeconds * 1000).toInt()), () {
        if (mounted) {
          if (wordIdx < words.length - 1) {
            setState(() {
              wordIdx = wordIdx + 1;
            });
          }
        }
      });
    }

    return Column(
      children: [
        Wrap(
            spacing: MossyPadding.md,
            runSpacing: 0,
            alignment: WrapAlignment.center,
            children: [
              for (var wIdx = 0; wIdx < words.length; wIdx += 1)
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: wIdx < wordIdx
                      ? 0.5
                      : wIdx > wordIdx
                          ? 0.2
                          : 1.0,
                  child: words[wIdx] == '¶'
                      ? SizedBox(
                          width: double.infinity,
                          height: MossyPadding.md,
                        )
                      : MText(words[wIdx], fontSize: MossyFontSize.lg),
                )
            ]),
      ],
    );
  }
}

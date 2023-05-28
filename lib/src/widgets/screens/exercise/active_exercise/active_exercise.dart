import 'package:flutter/widgets.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:mossy_vibes/src/widgets/atoms/full_width.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/breath_animation.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/complete_buttons.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/prompt_scroller.dart';
import 'package:provider/provider.dart';

import '../../../../../_state.dart';
import '../../../../utils/theme.dart';

class ActiveExercise extends StatefulWidget {
  final int currentPromptIdx;
  final void Function() onNext;
  final void Function() onReset;
  final Exercise exercise;
  final bool isComplete;

  ActiveExercise(
      {required this.currentPromptIdx,
      required this.onNext,
      required this.exercise,
      required this.isComplete,
      required this.onReset});

  @override
  State<ActiveExercise> createState() => _ActiveExerciseState();
}

class _ActiveExerciseState extends State<ActiveExercise> {
  bool isBreathAnimationOn = false;

  @override
  void initState() {
    isBreathAnimationOn = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    final screenHeight = MediaQuery.of(context).size.height;

    final promptHeight = screenHeight * (1.0 / 4);

    final prompt = widget.exercise.prompts[widget.currentPromptIdx];
    if (prompt.type == BreathType.toggle) {
      setState(() {
        isBreathAnimationOn = !isBreathAnimationOn;
      });
    }

    return FullWidth(
        child: Column(
      children: [
        SizedBox(
            height: promptHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PromptScroller(
                    currentPromptIdx: widget.currentPromptIdx,
                    exercise: widget.exercise,
                    onNext: widget.onNext,
                    isComplete: widget.isComplete)
              ],
            )),
        SizedBox(
          height: MossyPadding.xl,
        ),
        BreathAnimation(
          preferences: appState.preferences,
          isVisible: isBreathAnimationOn,
        ),
        CompleteButtons(
          isComplete: widget.isComplete,
          onReset: widget.onReset,
        )
      ],
    ));
  }
}

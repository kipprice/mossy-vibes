import 'package:flutter/widgets.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/breath_animation.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/complete_buttons.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/prompt_scroller.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/exercise_state.dart';
import 'package:provider/provider.dart';

import '../../../../../_state.dart';
import '../../../../utils/theme.dart';

class ActiveExercise extends StatelessWidget {
  ActiveExercise({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    ExerciseContext exerciseState = ExerciseContext.of(context);
    Exercise exercise = exerciseState.exercise;
    bool isBreathAnimationOn = exerciseState.isBreathAnimationOn;

    final screenHeight = MediaQuery.of(context).size.height;

    final promptHeight = screenHeight * (1.0 / 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: promptHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PromptScroller(
                key: Key('prompts-${exercise.id}'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MossyPadding.xl,
        ),
        Stack(
          children: [
            Center(
              child: BreathAnimation(
                preferences: appState.preferences,
                isVisible: isBreathAnimationOn,
              ),
            ),
            CompleteButtons()
          ],
        )
      ],
    );
  }
}

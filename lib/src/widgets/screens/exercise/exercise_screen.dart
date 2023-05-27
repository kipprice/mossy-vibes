import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/full_width.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/active_exercise.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/active_exercise/breath_animation.dart';
import 'package:mossy_vibes/src/widgets/molecules/mossy_log.dart';
import 'package:mossy_vibes/src/widgets/screens/exercise/start_exercise.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../molecules/page_header/page_with_header.dart';

class ExerciseScreen extends StatefulWidget {
  final String exerciseId;

  ExerciseScreen({required this.exerciseId});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int currentPromptIdx = -1;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();
    final exercise = appState.exercises
        .where((exercise) => exercise.id == widget.exerciseId)
        .first;

    Widget statePage = currentPromptIdx == -1
        ? StartExercise(
            exercise: exercise,
            onStart: () {
              setState(() {
                currentPromptIdx = 0;
              });
            },
          )
        : ActiveExercise(
            currentPromptIdx: currentPromptIdx,
            onNext: () {
              if (mounted) {
                setState(() {
                  if (currentPromptIdx < exercise.prompts!.length - 1) {
                    currentPromptIdx += 1;
                  } else {
                    isComplete = true;
                  }
                });
              }
            },
            onReset: () {
              if (mounted) {
                setState(() {
                  currentPromptIdx = 0;
                  isComplete = false;
                });
              }
            },
            exercise: exercise,
            isComplete: isComplete);

    return MossyPageWithHeader(
        title: exercise.title ?? '',
        body: Column(children: [
          statePage,
          Expanded(
            child: SizedBox(height: MossyTheme.paddingMd),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: MossyTheme.paddingXl),
            child: MossyLog(),
          )
        ]));
  }
}

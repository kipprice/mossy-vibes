import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:mossy_vibes/src/services/analytics_service.dart';
import 'package:mossy_vibes/src/services/wakelock_service.dart';

import '../../../models/exercise.dart';

class ExerciseContextWidget extends StatefulWidget {
  final Exercise exercise;
  final Widget child;

  const ExerciseContextWidget(
      {super.key, required this.exercise, required this.child});

  @override
  State<ExerciseContextWidget> createState() => ExerciseContextWidgetState();
}

class ExerciseContextWidgetState extends State<ExerciseContextWidget> {
  int currentPromptIdx = -1;
  bool isComplete = false;
  bool isBreathAnimationOn = false;

  @override
  void dispose() {
    WakelockService().disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseContext(
      exercise: widget.exercise,
      currentPromptIdx: currentPromptIdx,
      isComplete: isComplete,
      isBreathAnimationOn: isBreathAnimationOn,
      exerciseState: this,
      child: widget.child,
    );
  }

  void onNext() async {
    if (!mounted) {
      return;
    }
    if (currentPromptIdx < widget.exercise.prompts.length - 1) {
      setState(() {
        currentPromptIdx += 1;

        if (widget.exercise.prompts[currentPromptIdx].type ==
            BreathType.toggle) {
          isBreathAnimationOn = !isBreathAnimationOn;
        }
      });
    } else {
      await WakelockService().disable();
      AnalyticsService().track(AnalyticsEventType.exerciseCompleted,
          {'exerciseId': widget.exercise.id});
      setState(() {
        isComplete = true;
      });
    }
  }

  void onReset() {
    if (!mounted) {
      return;
    }
    AnalyticsService().track(
        AnalyticsEventType.exerciseStarted, {'exerciseId': widget.exercise.id});
    setState(() {
      currentPromptIdx = 0;
      isComplete = false;
      isBreathAnimationOn = false;
    });
  }

  void onPause() {
    // TODO: implement
  }

  void onBack() {
    // TODO: implement
  }

  void onStart() async {
    await WakelockService().enable();
    AnalyticsService().track(
        AnalyticsEventType.exerciseStarted, {'exerciseId': widget.exercise.id});
    onNext();
  }
}

class ExerciseContext extends InheritedWidget {
  final ExerciseContextWidgetState exerciseState;
  final Exercise exercise;
  final int currentPromptIdx;
  final bool isComplete;
  final bool isBreathAnimationOn;

  const ExerciseContext(
      {super.key,
      required super.child,
      required this.exerciseState,
      required this.exercise,
      required this.currentPromptIdx,
      required this.isBreathAnimationOn,
      required this.isComplete});

  @override
  bool updateShouldNotify(ExerciseContext oldWidget) {
    if (oldWidget.exercise != exercise) {
      return true;
    }

    if (oldWidget.isBreathAnimationOn != isBreathAnimationOn) {
      return true;
    }

    if (oldWidget.currentPromptIdx != currentPromptIdx) {
      return true;
    }

    if (oldWidget.isComplete != isComplete) {
      return true;
    }

    return false;
  }

  static ExerciseContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExerciseContext>();
  }

  static ExerciseContext of(BuildContext context) {
    final ExerciseContext? result = maybeOf(context);
    assert(result != null, 'No ExerciseState found in context');
    return result!;
  }

  Prompt get currentPrompt => exercise.prompts[currentPromptIdx];

  // pass through functions to the state within this context
  void Function() get onNext => exerciseState.onNext;
  void Function() get onStart => exerciseState.onStart;
  void Function() get onReset => exerciseState.onReset;
}

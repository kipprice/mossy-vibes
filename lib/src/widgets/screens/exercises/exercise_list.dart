import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

import '../../../../_state.dart';
import '../../../models/filters.dart';
import '../../../utils/theme.dart';
import '../../atoms/animate_fade.dart';
import 'exercise_line.dart';

class ExerciseList extends StatelessWidget {
  /// The ExerciseSize that should be rendered in this list.
  final ExerciseSize mode;

  /// Whether this list is currently active and visible.
  final bool isVisible;

  /// Any additional filters that should be applied to this list.
  final Filters filters;

  /// Renders all of the exercises of a particular [mode] to the user in a scrollable way.
  ///
  /// The ExerciseList is embedded within the ExercisesScreen, and is intended
  /// to be specific to a particular ExerciseSize. This allows the entire list
  /// to fade in and out when the user opts to change the size of exercise that
  /// they're looking at
  ///
  /// Only a single ExerciseList will be visible at a time. The different modes
  /// of a List are stacked upon each other to make the transition very seamless.
  const ExerciseList(
      {super.key,
      required this.mode,
      required this.isVisible,
      required this.filters});

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    if (appState.status != MossyStatus.ready) {
      return Padding(
        padding: const EdgeInsets.all(MossyPadding.xl),
        child: CircularProgressIndicator(
          color: MossyColors.offWhite,
        ),
      );
    }

    final exercises = appState.exercises
        .where((ex) =>
            ex.size == mode &&
            filters.shouldShowExercise(ex, appState.preferences))
        .toList();

    exercises.sort((Exercise a, Exercise b) {
      final diffInMinutes = a.getLengthInMinutes(appState.preferences) -
          b.getLengthInMinutes(appState.preferences);
      if (diffInMinutes != 0) {
        return diffInMinutes;
      }

      return (a.dateAdded?.millisecondsSinceEpoch ?? 0) -
          (b.dateAdded?.millisecondsSinceEpoch ?? 0);
    });

    return AnimateFadeAndRemove(
      isVisible: isVisible,
      delayIn: 300,
      duration: 200,
      child: Padding(
        padding: const EdgeInsets.all(MossyPadding.md),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            for (var ex in exercises)
              ExerciseLine(
                key: Key(ex.id),
                exercise: ex,
                preferences: appState.preferences,
              ),
            (exercises.isEmpty
                ? MText(
                    '(No exercises match the current filters)',
                    fontSize: MossyFontSize.sm,
                  )
                : Container())
          ],
        ),
      ),
    );
  }
}

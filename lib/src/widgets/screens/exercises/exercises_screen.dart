import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/models/filters.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/exercise_list.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/filter_bar.dart';
import 'package:provider/provider.dart';

import '../../../../_state.dart';
import '../../molecules/page_with_header/page_with_header.dart';

class ExercisesScreen extends StatefulWidget {
  /// Renders all of the available exercises to the user.
  ///
  /// The ExercisesScreeen is one of the primary steps in the user flow to
  /// actually choose an exercise. From this screen, any exercise available to
  /// the user can be
  ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  Filters filters = Filters();

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    if (appState.status != MossyStatus.ready) {
      return MossyPageWithHeader(
        title: 'All Exercises',
        body: Column(
          children: [
            Center(
              child: Text('loading'),
            ),
          ],
        ),
      );
    } else {
      return MossyPageWithHeader(
        title: 'All Exercises',
        padding: 0.0,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            FiltersBar(
              filters: filters,
              onChangeFilters: (Filters f) {
                setState(() {
                  filters = f;
                });
              },
            ),
            Expanded(
              child: Stack(children: [
                ExerciseList(
                    mode: ExerciseSize.normal,
                    isVisible: filters.exerciseSize == ExerciseSize.normal,
                    filters: filters),
                ExerciseList(
                    mode: ExerciseSize.micro,
                    isVisible: filters.exerciseSize == ExerciseSize.micro,
                    filters: filters)
              ]),
            )
          ],
        ),
      );
    }
  }
}

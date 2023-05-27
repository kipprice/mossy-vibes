import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

/// FilterModeTabs allow the user to switch between different exercise sizes
/// on the exercises list screen. Currently, only standard and micro length
/// sizes are supported, but if we add longer meditations in the future, this
/// switcher can support them as well
class FilterModeTabs extends StatelessWidget {
  final void Function(ExerciseSize mode) onSetMode;
  final ExerciseSize mode;

  const FilterModeTabs(
      {super.key, required this.onSetMode, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      TextButton(
          onPressed: () {
            onSetMode(ExerciseSize.normal);
          },
          child: MText('Standard',
              fontWeight: MFontWeight.base,
              opacity: mode == ExerciseSize.normal ? 1 : 0.5,
              underline: mode == ExerciseSize.normal ? true : false)),
      TextButton(
          onPressed: () {
            onSetMode(ExerciseSize.micro);
          },
          child: MText('Micro',
              fontWeight: MFontWeight.base,
              opacity: mode == ExerciseSize.micro ? 1 : 0.5,
              underline: mode == ExerciseSize.micro ? true : false))
    ]);
  }
}

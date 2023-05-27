import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/models/filters.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../../../../utils/theme.dart';

class ExerciseLengthField extends StatelessWidget {
  final ExerciseLength length;
  final void Function(ExerciseLength length) onChangeLength;

  const ExerciseLengthField(
      {super.key, required this.length, required this.onChangeLength});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ExerciseLength>(
        value: length,
        decoration: InputDecoration(
            labelText: 'Length',
            labelStyle: TextStyle(
                color: MossyColors.offWhite, fontWeight: FontWeight.w500)),
        dropdownColor: MossyColors.darkestGreen,
        items: [
          for (var l in ExerciseLength.values)
            DropdownMenuItem(
                value: l,
                child: MText(
                  l.name,
                  color: MossyColors.offWhite,
                  fontWeight: MFontWeight.bold,
                ))
        ],
        onChanged: (length) {
          onChangeLength(length ?? ExerciseLength.all);
        });
  }
}

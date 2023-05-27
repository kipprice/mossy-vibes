import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/utils/string_extension.dart';

import '../../../../../models/filters.dart';
import '../../../../../utils/theme.dart';
import '../../../../atoms/mossy_text.dart';

class ExerciseTypeField extends StatelessWidget {
  final ExerciseType type;
  final void Function(ExerciseType t) onChangeType;

  const ExerciseTypeField(
      {super.key, required this.type, required this.onChangeType});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            labelText: 'Exercise Type',
            labelStyle: TextStyle(
                color: MossyColors.offWhite, fontWeight: FontWeight.w500)),
        dropdownColor: MossyColors.darkestGreen,
        items: [
          for (var t in [ExerciseType.all, ExerciseType.favorites])
            DropdownMenuItem(
                value: t,
                child: MText(
                  t.name.capitalize(),
                  color: MossyColors.offWhite,
                  fontWeight: MFontWeight.bold,
                )),
        ],
        value: type,
        onChanged: (v) {
          onChangeType(v as ExerciseType);
        });
  }
}

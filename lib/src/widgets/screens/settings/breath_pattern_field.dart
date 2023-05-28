import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/utils/string_extension.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

import '../../../../_state.dart';
import '../../../models/breath_pattern.dart';

class BreathPatternField extends StatelessWidget {
  const BreathPatternField({super.key});

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    return DropdownButtonFormField<BreathPattern>(
        decoration: InputDecoration(
            labelText: 'What breathing speed do you prefer?',
            labelStyle: TextStyle(
                color: MossyColors.offWhite,
                fontWeight: FontWeight.w500,
                fontSize: MossyFontSize.md)),
        dropdownColor: MossyColors.darkestGreen,
        value: appState.preferences.breathPattern,
        items: [
          for (var pattern in BreathPattern.values)
            DropdownMenuItem(
                value: pattern,
                child: MText(
                  pattern.name.capitalize(),
                  fontWeight: MFontWeight.base,
                )),
        ],
        onChanged: (pattern) {
          appState.changeBreathPattern(pattern ?? BreathPattern.calm);
        });
  }
}

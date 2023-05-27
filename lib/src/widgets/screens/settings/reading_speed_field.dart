import 'package:flutter/material.dart';
import 'package:mossy_vibes/main.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

class ReadingSpeedField extends StatelessWidget {
  const ReadingSpeedField({super.key});

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();

    return DropdownButtonFormField<int>(
        decoration: InputDecoration(
            labelText: 'What reading speed do you prefer?',
            labelStyle: TextStyle(
                color: MossyColors.offWhite,
                fontWeight: FontWeight.w500,
                fontSize: MossyFontSize.md)),
        dropdownColor: MossyColors.darkestGreen,
        value: appState.preferences.readingSpeedInWpm,
        items: [
          DropdownMenuItem(
              value: 75,
              child: MText(
                'Leisurely',
                fontWeight: MFontWeight.base,
              )),
          DropdownMenuItem(
              value: 150,
              child: MText(
                'Standard',
                fontWeight: MFontWeight.base,
              )),
          DropdownMenuItem(
              value: 200,
              child: MText(
                'Quick',
                fontWeight: MFontWeight.base,
              )),
          DropdownMenuItem(
              value: 250,
              child: MText(
                'Speedy',
                fontWeight: MFontWeight.base,
              ))
        ],
        onChanged: (speed) {
          appState.changeReadingSpeed(speed ?? 150);
        });
  }
}

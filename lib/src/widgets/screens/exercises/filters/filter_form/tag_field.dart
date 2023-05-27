import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../main.dart';
import '../../../../../utils/theme.dart';
import '../../../../atoms/mossy_text.dart';

class TagField extends StatelessWidget {
  final String tag;
  final void Function(String t) onChangeTag;

  const TagField({super.key, required this.tag, required this.onChangeTag});

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();
    final tags = Set<String>();
    for (var ex in appState.exercises) {
      ex.tags != null ? tags.addAll(ex.tags!) : null;
    }

    return DropdownButtonFormField<String>(
        dropdownColor: MossyColors.darkestGreen,
        decoration: InputDecoration(
            labelText: 'Tag',
            labelStyle: TextStyle(
                color: MossyColors.offWhite, fontWeight: FontWeight.w500)),
        items: [
          DropdownMenuItem(
              value: '',
              child: MText(
                'All',
                color: MossyColors.offWhite,
                fontWeight: MFontWeight.base,
              )),
          for (var tag in tags)
            DropdownMenuItem(
                value: tag,
                child: MText(
                  tag,
                  color: MossyColors.offWhite,
                  fontWeight: MFontWeight.bold,
                ))
        ],
        onChanged: (tag) {
          onChangeTag(tag ?? '');
        },
        value: tag);
  }
}

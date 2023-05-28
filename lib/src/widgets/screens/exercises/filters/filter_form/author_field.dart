import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../_state.dart';
import '../../../../../utils/theme.dart';
import '../../../../atoms/mossy_text.dart';

class AuthorField extends StatelessWidget {
  final String author;
  final void Function(String a) onChangeAuthor;

  const AuthorField(
      {super.key, required this.author, required this.onChangeAuthor});

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch<MossyVibesState>();
    final authors = appState.exercises.map((ex) => ex.author).toSet();

    return DropdownButtonFormField<String>(
        dropdownColor: MossyColors.darkestGreen,
        decoration: InputDecoration(
            labelText: 'Author',
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
          for (var author in authors)
            DropdownMenuItem(
                value: author,
                child: MText(
                  author!,
                  color: MossyColors.offWhite,
                  fontWeight: MFontWeight.bold,
                ))
        ],
        onChanged: (author) {
          onChangeAuthor(author ?? '');
        },
        value: author);
  }
}

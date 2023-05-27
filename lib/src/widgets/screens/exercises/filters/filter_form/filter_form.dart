import 'package:flutter/material.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/filter_form/author_field.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/filter_form/exercise_length_field.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/filter_form/exercise_type_field.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/filter_form/tag_field.dart';

import '../../../../../models/filters.dart';
import '../../../../../utils/theme.dart';

class FilterForm extends StatelessWidget {
  final Filters filters;
  final void Function(Filters filters) onChangeFilters;

  const FilterForm(
      {super.key, required this.filters, required this.onChangeFilters});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MossyPadding.lg),
        child: Column(children: [
          MText(
            'Filters',
            fontSize: MossyFontSize.lg,
            fontWeight: MFontWeight.base,
          ),
          Form(
              key: Key('filters_form'),
              child: Column(
                children: [
                  ExerciseTypeField(
                      type: filters.exerciseType,
                      onChangeType: (dynamic v) {
                        filters.exerciseType = v;
                        onChangeFilters(filters);
                      }),
                  SizedBox(
                    height: MossyPadding.lg,
                  ),
                  ExerciseLengthField(
                      length: filters.exerciseLength,
                      onChangeLength: (ExerciseLength l) {
                        filters.exerciseLength = l;
                        onChangeFilters(filters);
                      }),
                  SizedBox(
                    height: MossyPadding.lg,
                  ),
                  AuthorField(
                      author: filters.author,
                      onChangeAuthor: (dynamic v) {
                        filters.author = v;
                        onChangeFilters(filters);
                      }),
                  SizedBox(
                    height: MossyPadding.lg,
                  ),
                  TagField(
                      tag: filters.tag,
                      onChangeTag: (dynamic v) {
                        filters.tag = v;
                        onChangeFilters(filters);
                      }),
                  SizedBox(
                    height: MossyPadding.lg,
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}

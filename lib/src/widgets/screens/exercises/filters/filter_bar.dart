import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mossy_vibes/src/models/exercise.dart';
import 'package:mossy_vibes/src/utils/theme.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/filter_form/filter_form.dart';
import 'package:mossy_vibes/src/widgets/screens/exercises/filters/mode_tabs.dart';

import '../../../../models/filters.dart';

/// Renders the filters available in the exercise screen. Supports swapping
/// between the different exercise sizes as well as the other filters that can
/// apply on this screen. State is managed by the parent (ExercisesScreen),
/// since the filters get applied to the list elements directly.
class FiltersBar extends StatelessWidget {
  final Filters filters;
  final void Function(Filters filters) onChangeFilters;

  const FiltersBar(
      {super.key, required this.filters, required this.onChangeFilters});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: MossyColors.lightGreen.withAlpha(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: MossyPadding.md, horizontal: MossyPadding.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterModeTabs(
              onSetMode: (ExerciseSize es) {
                filters.exerciseSize = es;
                onChangeFilters(filters);
              },
              mode: filters.exerciseSize,
            ),
            Row(
              children: [
                filters.appliedCount > 0
                    ? TextButton(
                        onPressed: () {
                          filters.clear();
                          onChangeFilters(filters);
                        },
                        child: MText(
                          'Clear Filters',
                          fontSize: MossyFontSize.sm,
                          fontWeight: MFontWeight.base,
                        ))
                    : Container(),
                IconButton(
                  focusColor: MossyColors.offWhite.withAlpha(30),
                  hoverColor: MossyColors.offWhite.withAlpha(30),
                  highlightColor: MossyColors.offWhite.withAlpha(30),
                  icon: SvgPicture.asset(
                    'assets/svg/filter.svg',
                    semanticsLabel: 'filter these exercises',
                    height: 24,
                    width: 24,
                    colorFilter:
                        ColorFilter.mode(MossyColors.offWhite, BlendMode.srcIn),
                  ),
                  onPressed: () {
                    showBarModalBottomSheet(
                        isDismissible: true,
                        context: context,
                        backgroundColor: MossyColors.darkGreen,
                        builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: FilterForm(
                                filters: filters,
                                onChangeFilters: onChangeFilters,
                              ),
                            ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

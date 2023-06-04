import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';
import 'package:provider/provider.dart';

import '../../../../_state.dart';
import '../../../models/exercise.dart';
import '../../../models/preferences.dart';
import '../../../utils/theme.dart';

class ExerciseLine extends StatelessWidget {
  /// The exercise this line is displaying.
  final Exercise exercise;

  /// The UserPreferences that determine time and favorite calculations.
  final UserPreferences preferences;

  /// Renders the specified [exercise] in a ListView.
  ///
  /// The ExerciseLine display is relatively limited, only displaying the title
  /// of the exercise, the author, and the amount of time it is estimated to
  /// take the viewer, based on their current reading and breathing speeds. It
  /// additionally allows for a user to set or unset an exercise as a favorite.
  ///
  /// The line itself is broken into two Pressable elements; the left side is
  /// the favorite / unfavorite button, which will toggle whether this exercise
  /// is tracked as a user favorite. The right side allows the user to select
  /// this exercise, taking them into the ExerciseScreen and out of the list.
  ExerciseLine({super.key, required this.exercise, required this.preferences});

  @override
  Widget build(BuildContext context) {
    MossyVibesState appState = context.watch();
    final isFavorite = preferences.favorites.contains(exercise.id);
    final lengthInMinutes = exercise.getLengthInMinutes(appState.preferences);

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            focusColor: MossyColors.offWhite.withAlpha(30),
            hoverColor: MossyColors.offWhite.withAlpha(30),
            highlightColor: MossyColors.offWhite.withAlpha(30),
            onPressed: () {
              appState.toggleFavorite(exercise.id);
            },
            icon: SvgPicture.asset(
                isFavorite
                    ? 'assets/svg/star_fill.svg'
                    : 'assets/svg/star_outline.svg',
                semanticsLabel: isFavorite
                    ? 'favorite exercise'
                    : 'not a favorite exercise',
                colorFilter:
                    ColorFilter.mode(MossyColors.lightOrange, BlendMode.srcIn),
                height: MossyPadding.xl,
                width: MossyPadding.xl),
          ),
          SizedBox(
            width: MossyPadding.md,
          ),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith((states) =>
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MossyPadding.lg))),
              ),
              onPressed: () {
                context.go('/exercises/${exercise.id}');
              },
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Wrap(
                            spacing: MossyPadding.md,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              MText(
                                exercise.title ?? '',
                                fontSize: MossyFontSize.lg,
                                fontWeight: MFontWeight.base,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: MossyPadding.sm),
                                child: MText(
                                  'by ${exercise.author}',
                                  fontSize: MossyFontSize.sm,
                                ),
                              )
                            ]),
                        MText(
                          '$lengthInMinutes minute${lengthInMinutes == 1 ? '' : 's'}',
                        )
                      ])),
                  SizedBox(
                    width: MossyPadding.md,
                  ),
                  SvgPicture.asset(
                    'assets/svg/right_arrow.svg',
                    colorFilter:
                        ColorFilter.mode(MossyColors.offWhite, BlendMode.srcIn),
                    width: MossyPadding.xl,
                    height: MossyPadding.xl,
                  ),
                ],
              ),
            ),
          ),
        ]),
        SizedBox(height: MossyPadding.lg)
      ],
    );
  }
}

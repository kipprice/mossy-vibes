import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mossy_vibes/src/widgets/atoms/animate_fade.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../../../utils/theme.dart';
import '../../../atoms/inline_button.dart';

class CompleteButtons extends StatefulWidget {
  final bool isComplete;
  final void Function() onReset;

  const CompleteButtons(
      {super.key, required this.isComplete, required this.onReset});

  @override
  State<CompleteButtons> createState() => _CompleteButtonsState();
}

class _CompleteButtonsState extends State<CompleteButtons> {
  @override
  Widget build(BuildContext context) {
    return AnimateFadeAndRemove(
      isVisible: widget.isComplete,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MossyPadding.xl),
        child: Row(
          children: [
            Expanded(
              child: InlineButton(
                  onPressed: () {
                    context.go('/exercises');
                  },
                  child: MText(
                    'Back to Exercises',
                    fontWeight: MFontWeight.base,
                  )),
            ),
            SizedBox(width: MossyPadding.lg),
            Expanded(
                child: InlineButton(
                    onPressed: widget.onReset,
                    child: MText(
                      'Restart',
                      fontWeight: MFontWeight.base,
                    )))
          ],
        ),
      ),
    );
  }
}

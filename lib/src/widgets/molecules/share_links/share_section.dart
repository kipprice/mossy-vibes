import 'package:flutter/widgets.dart';
import 'package:mossy_vibes/src/widgets/atoms/mossy_text.dart';

import '../../../utils/theme.dart';

class ShareSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  ShareSection({required this.title, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MText(
          title,
          fontSize: MossyTheme.fontLg,
          fontWeight: MFontWeight.base,
          underline: true,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: children),
      ],
    );
  }
}

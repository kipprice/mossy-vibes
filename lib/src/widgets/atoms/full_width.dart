import 'package:flutter/widgets.dart';

class FullWidth extends StatelessWidget {
  /// The child to expand to the full width of the screen.
  final Widget child;

  /// Renders its child using the full width of the containing element.
  FullWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Row(children: [Expanded(child: child)]));
  }
}

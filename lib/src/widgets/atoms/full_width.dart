import 'package:flutter/widgets.dart';

class FullWidth extends StatelessWidget {
  final Widget child;

  FullWidth({required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Row(children: [Expanded(child: child)]));
  }
}

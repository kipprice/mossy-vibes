import 'package:flutter/widgets.dart';

class MossyLog extends StatelessWidget {
  final double opacity;

  MossyLog({super.key, this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'log_hero',
      child: Opacity(
        opacity: opacity,
        child: Image.asset(
          'assets/img/log.png',
        ),
      ),
    );
  }
}

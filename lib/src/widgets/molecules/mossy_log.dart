import 'package:flutter/widgets.dart';

class MossyLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'log_hero',
      child: Image.asset(
        'assets/img/log.png',
      ),
    );
  }
}

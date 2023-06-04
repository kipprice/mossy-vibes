import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mossy_vibes/src/models/preferences.dart';
import 'package:mossy_vibes/src/models/prompt.dart';
import 'package:mossy_vibes/src/widgets/atoms/animate_fade.dart';

class BreathAnimation extends StatefulWidget {
  final UserPreferences preferences;
  final bool isVisible;
  final bool isPaused;

  /// Renders a simple breath in - hold - out animation to the user.
  ///
  /// The BreathAnimation manages its own animation state, including
  /// fading in and out when appropriate.
  ///
  /// TODO: support pausing
  /// TODO: support going backwards
  BreathAnimation(
      {required this.preferences,
      this.isVisible = true,
      this.isPaused = false});

  @override
  State<BreathAnimation> createState() => _BreathAnimationState();
}

class _BreathAnimationState extends State<BreathAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? breathController;
  Animation? rotationAnimation;
  Animation? sizeAnimation;

  AnimationController? fadeController;
  Animation? opacityAnimation;

  @override
  void initState() {
    super.initState();

    final preferences = widget.preferences;

    breathController = AnimationController(
        vsync: this,
        duration:
            Duration(seconds: preferences.calculateFullBreathInSeconds()));

    rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(parent: breathController!, curve: Curves.linear));

    sizeAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 0),
          weight: preferences.calculateBreathRatio(BreathType.intake)),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 0),
          weight: preferences.calculateBreathRatio(BreathType.hold)),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 1),
          weight: preferences.calculateBreathRatio(BreathType.out)),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 1),
          weight: preferences.calculatePaddingRatio())
    ]).animate(
        CurvedAnimation(parent: breathController!, curve: Curves.linear));

    breathController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    breathController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double maxSize = min(screenWidth * 0.8, screenHeight * 0.33);
    double minSize = maxSize * 0.71;
    double diff = maxSize - minSize;

    final innerSvg = SvgPicture.asset(
      'assets/svg/circle.svg',
      height: minSize,
      width: minSize,
    );

    final outerSvg = SvgPicture.asset(
      'assets/svg/circle_ring.svg',
      height: maxSize - ((sizeAnimation?.value ?? 1) * diff),
      width: maxSize - ((sizeAnimation?.value ?? 1) * diff),
    );

    if (!widget.isVisible) {
      breathController?.stop();
      breathController?.reset();
    } else if (widget.isPaused) {
      breathController?.stop();
    } else {
      breathController?.repeat();
    }

    return AnimateFadeAndRemove(
      isVisible: widget.isVisible,
      child: SizedBox(
          width: maxSize,
          height: maxSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              innerSvg,
              Transform.rotate(angle: rotationAnimation!.value, child: outerSvg)
            ],
          )),
    );
  }
}

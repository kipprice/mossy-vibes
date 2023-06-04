import 'dart:async';

import 'package:flutter/material.dart';

enum AnimateFadeStatus {
  unrendered(isRendered: false, opacity: 0),
  added(isRendered: true, opacity: 0),
  ready(isRendered: true, opacity: 1),
  fadingOut(isRendered: true, opacity: 0),
  removed(isRendered: false, opacity: 0);

  const AnimateFadeStatus({required this.isRendered, required this.opacity});
  final bool isRendered;
  final double opacity;
}

class AnimateFadeAndRemove extends StatefulWidget {
  final bool isVisible;
  final Widget child;
  final int delayIn;
  final int duration;
  final int delayOut;

  /// Creates an element that can be faded in and out.
  ///
  /// In addition to the functionality offered by AnimatedOpacity, this
  /// element also ensures that elements that are fully transparent are removed
  /// from the render all together.
  const AnimateFadeAndRemove({
    super.key,
    required this.isVisible,
    required this.child,
    this.delayIn = 1,
    this.delayOut = 0,
    this.duration = 400,
  });

  @override
  State<AnimateFadeAndRemove> createState() => _AnimateFadeState();
}

class _AnimateFadeState extends State<AnimateFadeAndRemove> {
  AnimateFadeStatus status = AnimateFadeStatus.unrendered;
  Timer? _renderTimer;
  Timer? _removeTimer;
  Timer? _fadeTimer;

  @override
  void dispose() {
    _renderTimer?.cancel();
    _removeTimer?.cancel();
    _fadeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // render if visible
    if (widget.isVisible && !status.isRendered) {
      setState(() {
        status = AnimateFadeStatus.added;
      });
      _renderTimer = Timer(Duration(milliseconds: widget.delayIn), () {
        setState(() {
          status = AnimateFadeStatus.ready;
        });
      });
    }

    // otherwise remove this element
    if (!widget.isVisible && status.isRendered) {
      setState(() {
        status = AnimateFadeStatus.fadingOut;
      });
      _removeTimer =
          Timer(Duration(milliseconds: widget.duration + widget.delayOut), () {
        setState(() {
          status = AnimateFadeStatus.removed;
        });
      });
    }

    return status.isRendered
        ? AnimatedOpacity(
            opacity: status.opacity,
            duration: Duration(milliseconds: widget.duration),
            child: widget.child)
        : Container();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

class AnimateFadeAndRemove extends StatefulWidget {
  final bool isVisible;
  final Widget child;
  final int delay;
  final int duration;

  /// Creates an element that can be faded in and out.
  ///
  /// In addition to the functionality offered by AnimatedOpacity, this
  /// element also ensures that elements that are fully transparent are removed
  /// from the render all together.
  const AnimateFadeAndRemove(
      {super.key,
      required this.isVisible,
      required this.child,
      this.delay = 1,
      this.duration = 400});

  @override
  State<AnimateFadeAndRemove> createState() => _AnimateFadeState();
}

class _AnimateFadeState extends State<AnimateFadeAndRemove> {
  bool _isRendered = false;
  bool _isFadingIn = false;
  Timer? _fadeInTimer;
  Timer? _removeTimer;

  @override
  void dispose() {
    _fadeInTimer?.cancel();
    _removeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // render if visible
    if (widget.isVisible && !_isRendered) {
      setState(() {
        _isRendered = true;
        _isFadingIn = true;
      });
      _fadeInTimer = Timer(Duration(milliseconds: widget.delay), () {
        setState(() {
          _isFadingIn = false;
        });
      });
    }

    // otherwise remove this element
    if (!widget.isVisible && _isRendered) {
      _removeTimer =
          Timer(Duration(milliseconds: widget.duration + widget.delay), () {
        if (mounted) {
          setState(() {
            _isRendered = false;
          });
        }
      });
    }

    return _isRendered
        ? AnimatedOpacity(
            opacity: widget.isVisible && !_isFadingIn ? 1.0 : 0.0,
            duration: Duration(milliseconds: widget.duration),
            child: widget.child)
        : Container();
  }
}

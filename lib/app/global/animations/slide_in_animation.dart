import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int delay;
  final List<double>? x;
  final List<double>? y;
  final List<double>? z;
  final Curve? curve;

  SlideInAnimation(
      {required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay: 0,
      this.x,
      this.y,
      this.z,
      this.curve});
  @override
  _SlideInAnimationState createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> opacity;
  late Animation<double>? x;
  late Animation<double>? y;
  late Animation<double>? z;
  late Timer? _timer;

  initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: widget.curve ?? Curves.easeOutCirc));

    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.2)));
    x = (widget.x != null)
        ? Tween<double>(begin: widget.x![0], end: widget.x![1])
            .animate(animation)
        : null;
    y = (widget.y != null)
        ? Tween<double>(begin: widget.y![0], end: widget.y![1])
            .animate(animation)
        : null;
    z = (widget.z != null)
        ? Tween<double>(begin: widget.z![0], end: widget.z![1])
            .animate(animation)
        : null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(Duration(milliseconds: widget.delay), () {
        controller.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: AnimatedBuilder(
          child: widget.child,
          animation: controller,
          builder: (context, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(
                  x?.value ?? 0.0,
                  y?.value ?? 0.0,
                  z?.value ?? 0.0,
                ),
              child: child)),
    );
  }

  dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}

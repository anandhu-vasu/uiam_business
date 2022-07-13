import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ZoomInAngleAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double angle;
  final double zoomFrom;
  final double zoomTo;
  final Curve curve;

  ZoomInAngleAnimation(
      {required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay: const Duration(milliseconds: 0),
      this.angle: 15,
      this.zoomTo: 1.0,
      this.zoomFrom: 0.25,
      this.curve: Curves.linear});
  @override
  _ZoomInAngleAnimationState createState() => _ZoomInAngleAnimationState();
}

class _ZoomInAngleAnimationState extends State<ZoomInAngleAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> opacity;
  late Animation<double> zoom;
  late Animation<double> angle;
  late Timer? _timer;
  initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.3, curve: widget.curve)));
    zoom = Tween<double>(begin: widget.zoomFrom, end: widget.zoomTo).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.25, 0.75, curve: widget.curve)));
    angle = Tween<double>(begin: widget.angle * pi / 180, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.25, 0.75, curve: widget.curve)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(widget.delay, () {
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
                ..scale(zoom.value)
                ..rotateZ(angle.value),
              child: child)),
    );
  }

  dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}

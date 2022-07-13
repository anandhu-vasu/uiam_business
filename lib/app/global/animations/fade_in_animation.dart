import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class FadeInAnimation extends StatefulWidget {
  Widget child;
  Duration duration;
  int delay;

  FadeInAnimation(
      {required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay: 0});

  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  Timer? _timer;

  initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(Duration(milliseconds: widget.delay), () {
        controller.forward();
      });
    });
  }

  dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}

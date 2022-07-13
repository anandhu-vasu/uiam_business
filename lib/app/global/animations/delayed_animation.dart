import 'dart:async';

import 'package:flutter/material.dart';

enum DelayedAnimationDirection { fromBottom, fromTop, fromLeft, fromRight }

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final Duration duration;
  final DelayedAnimationDirection direction;
  final double offset;

  DelayedAnimation(
      {required this.child,
      this.delay: 0,
      this.duration: const Duration(milliseconds: 800),
      this.direction: DelayedAnimationDirection.fromBottom,
      this.offset: 0.35});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);

    late Offset offset;
    switch (widget.direction) {
      case DelayedAnimationDirection.fromBottom:
        offset = Offset(0.0, widget.offset);
        break;
      case DelayedAnimationDirection.fromTop:
        offset = Offset(0.0, -widget.offset);
        break;
      case DelayedAnimationDirection.fromRight:
        offset = Offset(widget.offset, 0.0);
        break;
      case DelayedAnimationDirection.fromLeft:
        offset = Offset(-widget.offset, 0.0);
        break;
    }

    _animOffset = Tween<Offset>(begin: offset, end: Offset.zero).animate(curve);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _controller,
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class FlipAnimation extends StatefulWidget {
  final Widget front;
  final Widget rear;
  final Function()? onTap;

  FlipAnimation({Key? key, required this.front, required this.rear, this.onTap})
      : super(key: key);

  @override
  FlipAnimationState createState() => FlipAnimationState();
}

class FlipAnimationState extends State<FlipAnimation> {
  late bool _showFront;
  late bool _flipXAxis;
  late bool _flipRight;

  @override
  void initState() {
    super.initState();
    _showFront = true;
    _flipXAxis = true;
    _flipRight = true;
  }

  bool get isFront => _showFront;

  set setFront(bool front) => setState(() {
        _showFront = front;
      });

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation();
  }

  void _switchCard() {
    setState(() {
      _showFront = !_showFront;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: widget.onTap,
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          // User swiped Left
          setState(() {
            _showFront = !_showFront;
            _flipRight = true;
          });
        } else if (details.primaryVelocity! < 0) {
          // User swiped Right
          setState(() {
            _showFront = !_showFront;
            _flipRight = false;
          });
        }
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFront ? widget.front : widget.rear,
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeOutBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFront) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        var value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;

        tilt = _flipRight ? tilt : -tilt;
        value = _flipRight ? value : -value;

        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}

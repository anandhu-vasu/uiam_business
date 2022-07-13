import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import '../animations/fade_in_animation.dart';
import '../animations/zoom_in_angel_animation.dart';

class ProgressButton extends StatefulWidget {
  Color? buttonColor;
  Color? disabledColor;
  Color? progressColor;
  final Future<bool?> Function() onPressed;
  final Function()? onCompleted;
  final Function()? onFailed;
  final double width;
  final double height;
  final double elevation;
  final Duration duration;
  final Widget child;
  final bool reset;

  ProgressButton(
      {Key? key,
      this.buttonColor,
      this.progressColor,
      required this.onPressed,
      required this.child,
      this.width: 360,
      this.height: 50,
      this.elevation: 5.0,
      this.onCompleted,
      this.onFailed,
      this.duration: const Duration(milliseconds: 1000),
      this.disabledColor,
      this.reset: false})
      : super(key: key) {
    buttonColor ??= Get.theme.primaryColor;
    progressColor ??= buttonColor;
  }

  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<ProgressButton> with AnimationMixin {
  late Animation<double> _width;
  late Animation<double> _size;
  late Animation<double> _opacity;
  late Animation<double> _elevation;
  late Animation<Color?> _color;
  int animationStatus = 0;

  @override
  void initState() {
    _width = Tween<double>(begin: widget.width, end: widget.height).animate(
        CurvedAnimation(parent: controller, curve: new Interval(0.0, 0.5)));
    _elevation = Tween<double>(begin: widget.elevation, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: new Interval(0.25, 0.5)));
    _color = ColorTween(begin: widget.buttonColor, end: widget.progressColor)
        .animate(
            CurvedAnimation(parent: controller, curve: Interval(0.25, 0.5)));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.45, 0.55)));
    _size = Tween<double>(begin: widget.height, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: new Interval(0.5, 0.75, curve: Curves.easeInExpo)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Center(
          child: Container(
            height: widget.height,
            width: widget.height,
            child: (animationStatus == 1)
                ? FadeTransition(
                    opacity: _opacity,
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color?>(
                            widget.progressColor),
                      ),
                    ))
                : (animationStatus == 2)
                    ? ZoomInAngleAnimation(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(widget.height),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.green.shade400,
                          ),
                        ),
                        zoomTo: 1.2,
                      )
                    : Container(),
          ),
        )),
        MaterialButton(
          color: widget.disabledColor ?? _color.value,
          elevation: _elevation.value,
          minWidth: 0,
          height: 0,
          padding: EdgeInsets.zero,
          shape: StadiumBorder(),
          onPressed: () {
            setState(() {
              animationStatus = 1;
            });
            controller.play(duration: widget.duration);
            widget.onPressed().then((bool? status) async {
              print("gduihjlksdjfksdflk$status");
              if (status != null) {
                if (status) {
                  setState(() {
                    animationStatus = 2;
                  });
                  print(animationStatus);
                  if (widget.onCompleted != null) await widget.onCompleted!();

                  Timer(5.seconds, () {
                    if (mounted && widget.reset) {
                      setState(() {
                        animationStatus = 0;
                      });
                      controller.playReverse(
                          duration: (widget.duration.inMilliseconds / 2)
                              .milliseconds);
                    }
                  });
                } else {
                  print("dsklfjasldkfj$status");
                  await controller.playReverse(duration: widget.duration);
                  setState(() {
                    animationStatus = 0;
                  });
                  if (widget.onFailed != null) await widget.onFailed!();
                }
              } else {
                if (widget.onCompleted != null) await widget.onCompleted!();
                if (widget.reset) {
                  setState(() {
                    animationStatus = 0;
                    controller.playReverse(duration: 0.seconds);
                  });
                }
              }
            });
          },
          child: Container(
            width: _width.value <= widget.height ? _size.value : _width.value,
            height: _size.value,
            child: animationStatus == 0
                ? Center(child: FadeInAnimation(child: widget.child))
                : Container(),
          ),
        ),
      ],
    );
  }

  void reverse() {
    controller.reverse();
    animationStatus = 0;
  }

  void reset() {
    controller.reset();
    animationStatus = 0;
  }
}

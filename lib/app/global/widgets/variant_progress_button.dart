import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_animations/anicoto/animation_mixin.dart';
import 'package:uiam_business/app/global/widgets/variant_button.dart';

import '../../../core/theme/variant_theme.dart';
import '../../data/enums/variant_button_size.dart';
import '../animations/fade_in_animation.dart';
import '../animations/zoom_in_angel_animation.dart';

class VariantProgressButton extends StatefulWidget {
  final dynamic content;
  final double? width;
  final double? height;
  final Future<bool?> Function() onTap;
  final Function()? onCompleted;
  final Function()? onFailed;
  final VariantColorScheme theme;
  final VariantButtonSize size;
  final BorderRadius? borderRadius;
  final bool circular;
  final Duration duration;
  final VariantProgressButtonController? controller;

  const VariantProgressButton(
      {Key? key,
      this.content,
      required this.onTap,
      this.width,
      this.theme = VariantTheme.primary,
      this.size = VariantButtonSize.medium,
      this.height,
      this.borderRadius,
      this.circular = false,
      this.duration = const Duration(milliseconds: 1000),
      this.onCompleted,
      this.onFailed,
      this.controller})
      : super(key: key);

  @override
  State<VariantProgressButton> createState() => _VariantProgressButtonState();
}

class _VariantProgressButtonState extends State<VariantProgressButton>
    with AnimationMixin {
  late Animation<double> _widthAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<BorderRadius> _borderRadiusAnimation;
  int animationStatus = 0;

  late final _height;
  late final _width;
  late final _borderRadius;

  @override
  void initState() {
    _height = widget.height ?? widget.size.height;
    _width = widget.width ?? (_height ?? widget.size.height);
    _borderRadius = widget.borderRadius ??
        BorderRadius.circular(
            widget.circular ? _height : widget.size.borderRadius);
    if (widget.controller != null) {
      widget.controller?.setState(this);
    }

    _widthAnimation = Tween<double>(begin: _width, end: _height).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.5)));
    _borderRadiusAnimation = Tween<BorderRadius>(
            begin: _borderRadius, end: BorderRadius.circular(_height))
        .animate(CurvedAnimation(
            parent: controller, curve: const Interval(0.0, 0.5)));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.45, 0.55)));

    _sizeAnimation = Tween<double>(begin: _height, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.75, curve: Curves.easeInExpo)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VariantButton(
          content: Container(
            width: _widthAnimation.value <= _height
                ? _sizeAnimation.value
                : _widthAnimation.value,
            height: _sizeAnimation.value,
            child: animationStatus == 0
                ? Center(
                    child: FadeInAnimation(
                        child: (widget.content is String)
                            ? Text(
                                widget.content,
                                style: TextStyle(
                                    color:
                                        widget.theme.onColor.withOpacity(.8)),
                              )
                            : ((widget.content is IconData)
                                ? Icon(
                                    widget.content,
                                    color: widget.theme.onColor.withOpacity(.8),
                                  )
                                : (widget.content is Widget)
                                    ? widget.content
                                    : Container())))
                : Container(),
          ),
          onTap: () async {
            if (animationStatus == 0) {
              setState(() {
                animationStatus = 1;
              });
              controller.forward();
              bool? ret = await widget.onTap();
              if (ret == null) {
                controller.reverse();
                await Future.delayed(const Duration(milliseconds: 400));
                setState(() {
                  animationStatus = 0;
                });
              } else if (ret == true) {
                setState(() {
                  animationStatus = 2;
                });
                await Future.delayed(const Duration(seconds: 2));
                if (widget.onCompleted != null) {
                  widget.onCompleted!();
                }
                controller.reverse();
                await Future.delayed(const Duration(milliseconds: 400));
                setState(() {
                  animationStatus = 0;
                });
              } else {
                setState(() {
                  animationStatus = 3;
                });
                await Future.delayed(const Duration(seconds: 2));
                if (widget.onFailed != null) {
                  widget.onFailed!();
                }
                controller.reverse();
                await Future.delayed(const Duration(milliseconds: 400));
                setState(() {
                  animationStatus = 0;
                });
              }
            }
          },
          width: _widthAnimation.value,
          height: _height,
          borderRadius: _borderRadiusAnimation.value,
          theme: widget.theme,
          size: widget.size,
          circular: widget.circular,
        ),
        Positioned.fill(
            child: Center(
          child: SizedBox(
            height: _height,
            width: _height,
            child: (animationStatus == 1)
                ? FadeTransition(
                    opacity: _opacityAnimation,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color?>(
                              widget.theme.onColor),
                        ),
                      ),
                    ))
                : (animationStatus == 2 || animationStatus == 3)
                    ? ZoomInAngleAnimation(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(_height),
                              boxShadow: [
                                BoxShadow(
                                  color: animationStatus == 3
                                      ? VariantTheme.danger.color
                                          .withOpacity(0.5)
                                      : VariantTheme.success.color
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ]),
                          child: Icon(
                            (animationStatus == 2)
                                ? Icons.check_rounded
                                : Icons.close_rounded,
                            color: widget.theme.onColor,
                          ),
                        ),
                        zoomTo: 1.2,
                        angle: animationStatus == 3 ? 0 : 15,
                        duration: const Duration(milliseconds: 500),
                      )
                    : Container(),
          ),
        )),
      ],
    );
  }

  void forward() {
    controller.forward();
    setState(() {
      animationStatus = 1;
    });
  }

  void reverse() {
    controller.reverse();
    setState(() {
      animationStatus = 0;
    });
  }

  void complete() {
    setState(() {
      animationStatus = 2;
    });
  }

  void fail() {
    setState(() {
      animationStatus = 3;
    });
  }

  void reset() {
    controller.reset();
    setState(() {
      animationStatus = 0;
    });
  }
}

class VariantProgressButtonController {
  late final _VariantProgressButtonState _state;

  void setState(_VariantProgressButtonState state) {
    _state = state;
  }

  void reverse() {
    _state.reverse();
  }

  void forward() {
    _state.forward();
  }

  void complete() {
    _state.complete();
  }

  void fail() {
    _state.fail();
  }

  void reset() {
    _state.reset();
  }
}

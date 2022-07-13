import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:uiam_business/app/global/widgets/backdrop_button.dart';

import '../../../core/theme/variant_theme.dart';
import '../../data/enums/variant_button_size.dart';
import '../animations/fade_in_animation.dart';
import '../animations/zoom_in_angel_animation.dart';

class BackdropProgressButton extends StatefulWidget {
  final dynamic content;
  final double? width;
  final double? height;
  final Future<bool?> Function() onTap;
  final Function()? onCompleted;
  final Function()? onFailed;
  final VariantButtonSize size;
  final BorderRadius? borderRadius;
  final bool rounded;
  final Duration duration;
  final BackdropProgressButtonController? controller;

  const BackdropProgressButton({
    this.content,
    required this.onTap,
    this.width,
    this.size = VariantButtonSize.medium,
    this.height,
    this.borderRadius,
    this.rounded = false,
    this.duration = const Duration(milliseconds: 1000),
    this.onCompleted,
    this.onFailed,
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  State<BackdropProgressButton> createState() => _BackdropProgressButtonState();
}

class _BackdropProgressButtonState extends State<BackdropProgressButton>
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
            widget.rounded ? _height : widget.size.borderRadius);

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
        BackdropButton(
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
                                    color: Get.theme.colorScheme.onBackground
                                        .withOpacity(.8)),
                              )
                            : ((widget.content is IconData)
                                ? Icon(
                                    widget.content,
                                    color: Get.theme.colorScheme.onBackground
                                        .withOpacity(.8),
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
              bool? ret = await widget.onTap.call();
              if (ret == null) {
                controller.reverse();
                await Future.delayed(const Duration(milliseconds: 500));
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
          size: widget.size,
          rounded: widget.rounded,
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
                          valueColor: AlwaysStoppedAnimation<Color?>(Get
                              .theme.colorScheme.onBackground
                              .withOpacity(.8)),
                        ),
                      ),
                    ))
                : (animationStatus == 2 || animationStatus == 3)
                    ? ZoomInAngleAnimation(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(_height),
                          ),
                          child: (animationStatus == 2)
                              ? Icon(
                                  Icons.check_rounded,
                                  color: VariantTheme.success.color,
                                )
                              : Icon(
                                  Icons.close_rounded,
                                  color: VariantTheme.danger.color,
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

class BackdropProgressButtonController {
  late final _BackdropProgressButtonState _state;

  void setState(_BackdropProgressButtonState state) {
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

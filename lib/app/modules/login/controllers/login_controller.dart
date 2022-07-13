import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uiam_business/app/global/widgets/backdrop_progress_button.dart';

import '../widgets/otp_field.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();

  late final AnimationController slideFadeController;
  late final Animation<Offset> slideAnimation;
  late final Animation<double> fadeAnimation1;
  late final Animation<double> fadeAnimation2;

  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  Completer? completer;
  bool isVerifying = false;
  final otpFieldController = OtpFieldController();
  final BackdropProgressButtonController? backdropProgressButtonController =
      BackdropProgressButtonController();

  @override
  void onInit() {
    super.onInit();
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() => update())
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() => update());

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() => update())
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() => update());

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();

    slideFadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: const Offset(0.0, -0.3),
    ).animate(CurvedAnimation(
      parent: slideFadeController,
      curve: Curves.linear,
    ));

    fadeAnimation1 = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: slideFadeController,
        curve: const Interval(
          0.10,
          0.60,
          curve: Curves.linear,
        ),
      ),
    );

    fadeAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: slideFadeController,
        curve: const Interval(
          0.20,
          0.60,
          curve: Curves.linear,
        ),
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller1.dispose();
    controller2.dispose();
    slideFadeController.dispose();
    super.onClose();
  }
}

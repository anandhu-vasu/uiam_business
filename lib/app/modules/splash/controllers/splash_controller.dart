import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement SplashController

  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  final opacity = 0.0.obs;
  final value = true.obs;
  @override
  void onInit() {
    super.onInit();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Get.find<AuthService>().redirect();
            Timer(
              const Duration(milliseconds: 300),
              () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 600), () {
      opacity.value = 1.0;
      value.value = false;
    });
    Timer(const Duration(milliseconds: 2000), () {
      initServices().then((_) => scaleController.forward());
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> initServices() async {
    print('starting services ...');

    Get.put(AuthService());

    print('All services started...');
  }

  @override
  void onClose() {
    scaleController.dispose();
    super.onClose();
  }
}

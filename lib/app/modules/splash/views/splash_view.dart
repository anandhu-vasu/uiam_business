import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/strings.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Text(
                      appNameShort,
                      style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      appFor.toUpperCase(),
                      style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Obx(() => AnimatedOpacity(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 6),
                  opacity: controller.opacity.value,
                  child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(seconds: 2),
                    height: controller.value.value ? 50 : 200,
                    width: controller.value.value ? 50 : 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.colorScheme.primary.withOpacity(.2),
                          blurRadius: 100,
                          spreadRadius: 10,
                        ),
                      ],
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.primary,
                                  shape: BoxShape.circle),
                              child: AnimatedBuilder(
                                animation: controller.scaleAnimation,
                                builder: (c, child) => Transform.scale(
                                  scale: controller.scaleAnimation.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                              child: Image.asset(
                            "assets/logo.jpg",
                            width: 80,
                            height: 80,
                          )),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uiam_business/app/global/widgets/backdrop_progress_button.dart';
import 'package:uiam_business/app/global/widgets/variant_button.dart';
import 'package:uiam_business/app/services/auth_service.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';
import 'package:uiam_business/core/values/consts.dart';

import '../../../global/widgets/avatar.dart';
import '../../../global/widgets/backdrop_button.dart';
import '../../../global/widgets/variant_progress_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  @override
  Widget builder() {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.QR_CODE);
          },
          child: Icon(Icons.qr_code_scanner_rounded),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: dSpace / 2, vertical: dSpace),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.BUSINESS_PROFILE_FORM);
                        },
                        child: Avatar(
                          controller.auth.user.image!,
                          blurRadius: 55,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: dSpace),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.auth.user.name!,
                            style: Get.theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.auth.signOut();
                        },
                        icon: Icon(Icons.logout))
                  ]),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: dSpace / 2, vertical: dSpace),
                child: Wrap(
                  spacing: dSpace,
                  runSpacing: dSpace,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: () {
                        Get.toNamed(Routes.APPOINTMENTS);
                      },
                      child: Container(
                        width:
                            screen.isDesktop ? screen.width / 3 : screen.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: dSpace / 4, vertical: dSpace),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            gradient: LinearGradient(colors: [
                              Color(0xAAFC5C7D),
                              Color(0xAA6A82FB),
                            ])),
                        child: Row(
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              color: Color.fromARGB(150, 250, 250, 250),
                              size: 100,
                            ),
                            Text(
                              "Appointments",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: () {
                        Get.toNamed(Routes.TIMESLOT);
                      },
                      child: Container(
                        width:
                            screen.isDesktop ? screen.width / 3 : screen.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: dSpace / 2, vertical: dSpace),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            gradient: LinearGradient(colors: [
                              Color(0xAA5C258D),
                              Color(0xAA4389A2),
                            ])),
                        child: Row(
                          children: [
                            Icon(
                              Icons.splitscreen_outlined,
                              color: Color.fromARGB(150, 250, 250, 250),
                              size: 100,
                            ),
                            Text("Timeslotes", style: TextStyle(fontSize: 25)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ])),
        ));
  }
}

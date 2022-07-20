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

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: dSpace / 2, vertical: dSpace),
          child: Row(children: [
            Avatar(
              controller.auth.user.image!,
              blurRadius: 55,
            ),
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
          ]),
        ),
        Container(
            padding:
                EdgeInsets.symmetric(horizontal: dSpace / 2, vertical: dSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: () {
                    Get.toNamed(Routes.APPOINTMENTS);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(dSpace / 4),
                    child: Column(
                      children: [
                        Icon(Icons.list_alt_rounded),
                        Text("Appointments"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: () {
                    Get.toNamed(Routes.TIMESLOT);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(dSpace / 4),
                    child: Column(
                      children: [
                        Icon(Icons.splitscreen_outlined),
                        Text("Timeslotes")
                      ],
                    ),
                  ),
                ),
              ],
            ))
      ])),
    ));
  }
}

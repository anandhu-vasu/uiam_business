import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uiam_business/app/global/widgets/backdrop_progress_button.dart';
import 'package:uiam_business/app/global/widgets/variant_button.dart';
import 'package:uiam_business/app/services/auth_service.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';
import 'package:uiam_business/core/values/consts.dart';

import '../../../global/widgets/backdrop_button.dart';
import '../../../global/widgets/variant_progress_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Get.find<AuthService>().signOut();
            },
          ),
        ],
      ),
      body: Center(
          child: VariantProgressButton(
        width: hSize / 2,
        content: "Hello World",
        onTap: () async {
          await Future.delayed(Duration(seconds: 2));
          return true;
        },
      )),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Get.toNamed('/qr-code');
      },
      child: Icon(Icons.qr_code_scanner_rounded),
    ),
    );
  }
}

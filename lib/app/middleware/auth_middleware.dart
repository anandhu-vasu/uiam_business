import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uiam_business/app/routes/app_pages.dart';
import 'package:uiam_business/app/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Get.find<AuthService>().isAuth || route == Routes.LOGIN
        ? null
        : RouteSettings(name: Routes.LOGIN, arguments: {"next": route});
  }
}

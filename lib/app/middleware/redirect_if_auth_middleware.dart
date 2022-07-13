import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

import '../services/auth_service.dart';

class RedirectIfAuth extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Get.find<AuthService>().isAuth && route != Routes.HOME
        ? const RouteSettings(name: Routes.HOME)
        : null;
  }
}

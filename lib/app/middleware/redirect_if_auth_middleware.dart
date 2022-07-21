import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

import '../services/auth_service.dart';

class RedirectIfAuth extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthService>();

    if (auth.loading) return const RouteSettings(name: Routes.LOADING);

    return auth.isAuth && route != Routes.HOME
        ? const RouteSettings(name: Routes.HOME)
        : null;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

import '../services/auth_service.dart';

class RedirectIfNoProfile extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print(Get.find<AuthService>().user);
    return Get.find<AuthService>().user.id == null
        ? RouteSettings(
            name: Routes.BUSINESS_PROFILE_FORM, arguments: {"next": route})
        : null;
  }
}

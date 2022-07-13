import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../middleware/redirect_if_auth_middleware.dart';
import '../middleware/redirect_if_no_profile_middleware.dart';
import '../modules/business_profile_form/bindings/business_profile_form_binding.dart';
import '../modules/business_profile_form/views/business_profile_form_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware(), RedirectIfNoProfile()]),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding(),
        middlewares: [RedirectIfAuth()]),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_PROFILE_FORM,
      page: () => const BusinessProfileFormView(),
      binding: BusinessProfileFormBinding(),
    ),
  ];
}

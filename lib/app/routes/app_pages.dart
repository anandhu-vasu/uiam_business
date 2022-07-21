import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../middleware/redirect_if_auth_middleware.dart';
import '../middleware/redirect_if_no_profile_middleware.dart';
import '../modules/appointments/bindings/appointments_binding.dart';
import '../modules/appointments/views/appointments_view.dart';
import '../modules/business_profile_form/bindings/business_profile_form_binding.dart';
import '../modules/business_profile_form/views/business_profile_form_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loading/bindings/loading_binding.dart';
import '../modules/loading/views/loading_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/qr_code/bindings/qr_code_binding.dart';
import '../modules/qr_code/views/qr_code_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/timeslot/bindings/timeslot_binding.dart';
import '../modules/timeslot/views/timeslot_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      children:[
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
      name: _Paths.BUSINESS_PROFILE_FORM,
      page: () => const BusinessProfileFormView(),
      binding: BusinessProfileFormBinding(),
    ),
    GetPage(
      name: _Paths.TIMESLOT,
      page: () => TimeslotView(),
      binding: TimeslotBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENTS,
      page: () => AppointmentsView(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: _Paths.QR_CODE,
      page: () => const QrCodeView(),
      binding: QrCodeBinding(),
    ),
      ]
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}

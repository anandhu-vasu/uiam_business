import 'package:get/get.dart';

import '../controllers/timeslot_controller.dart';

class TimeslotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeslotController>(
      () => TimeslotController(),
    );
  }
}

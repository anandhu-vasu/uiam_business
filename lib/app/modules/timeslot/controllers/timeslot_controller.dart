import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uiam_business/app/services/auth_service.dart';

import '../../../data/models/timeslot_model.dart';

class TimeslotController extends GetxController {
  final auth = Get.find<AuthService>();
  List<TimeslotModel> timeslots = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

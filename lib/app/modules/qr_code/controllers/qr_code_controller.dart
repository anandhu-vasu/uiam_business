import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uiam_business/app/data/models/appointment_model.dart';
import 'package:uiam_business/app/data/models/firestore_model.dart';
import 'package:uiam_business/app/data/models/timeslot_model.dart';
import 'package:uiam_business/app/data/providers/person_provider.dart';
import 'package:uiam_business/app/data/providers/timeslot_provider.dart';

import '../../../data/providers/appointment_provider.dart';
import '../../../services/auth_service.dart';

class QrCodeController extends GetxController {
  //TODO: Implement QrCodeController
  final qrCodeController = MobileScannerController(
    facing: CameraFacing.back,
  );
  final count = 0.obs;
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

  void increment() => count.value++;
  final auth = Get.find<AuthService>();

  Future<Map<String, FirestoreModel>> getAppointment(
      String pid, DateTime date) async {
    final appointments = (await AppointmentProvider(null).fetchAll(
            query: (ref, docId) => ref
                .where("bid", isEqualTo: auth.uid)
                .where("pid", isEqualTo: pid)
                .where("date",
                    isEqualTo:
                        date.toIso8601String().replaceFirst(RegExp(r'Z'), ''))))
        .where((appointment) => appointment.isVisited != true);
    final appointment =
        appointments.isEmpty ? AppointmentModel() : appointments.first;
    late final TimeslotModel timeslot;
    if (appointment.id == null) {
      timeslot = TimeslotModel();
    } else {
      timeslot = await TimeslotProvider(appointment.timeslotId).fetch();
    }

    final person = await PersonProvider(pid).fetch();
    return {'appointment': appointment, 'person': person, 'timeslot': timeslot};
  }
}

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/models/firestore_model.dart';
import '../../../data/models/timeslot_model.dart';
import '../../../data/providers/appointment_provider.dart';
import '../../../data/providers/business_provider.dart';
import '../../../data/providers/person_provider.dart';
import '../../../data/providers/timeslot_provider.dart';
import '../../../services/auth_service.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 3, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 3, kToday.month, kToday.day);

class AppointmentsController extends GetxController {
  final auth = Get.find<AuthService>();

  final calenderFormat = Rx<CalendarFormat>(CalendarFormat.week);
  final focusedDay = Rx<DateTime>(kToday);
  final selectedDay = Rxn<DateTime>(null);

  late final List<TimeslotModel> timeslots;

  @override
  void onInit() async {
    timeslots = (await TimeslotProvider(null).fetchAll(
            query: ((ref, docId) => ref.where("bid", isEqualTo: auth.uid))))
        .toList();
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

  Future<List<Map<String, FirestoreModel>>> getAppointments(
      {bool? isVisited, required TimeslotModel timeslot}) async {
    final appointments = await AppointmentProvider(null).fetchAll(
        query: ((ref, docId) => timeslot.id == null
            ? ref
                .where("date",
                    isEqualTo: selectedDay.value!
                        .toIso8601String()
                        .replaceFirst(RegExp(r'Z'), ''))
                .where("bid", isEqualTo: auth.uid)
                .where("timeslot_id", isNull: true)
                .where("is_visited", isEqualTo: isVisited)
            : ref
                .where("date",
                    isEqualTo: selectedDay.value!
                        .toIso8601String()
                        .replaceFirst(RegExp(r'Z'), ''))
                .where("bid", isEqualTo: auth.uid)
                .where("timeslot_id", isEqualTo: timeslot.id)
                .where("is_visited", isEqualTo: isVisited)));

    final result = appointments.map((appointment) async => {
          "appointment": appointment,
          "person": await PersonProvider(appointment.pid).fetch(),
          "timeslot": timeslot,
        });
    final list = (await Future.wait(result)).toList();

    list.sort((a, b) {
      final tsa = a['timeslot'] as TimeslotModel;
      final tsb = b['timeslot'] as TimeslotModel;
      return tsb.compareWith(tsa);
    });

    return list;
  }
}

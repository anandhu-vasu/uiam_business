import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/variant_theme.dart';
import '../../../../core/values/consts.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/models/firestore_model.dart';
import '../../../data/models/person_model.dart';
import '../../../data/models/timeslot_model.dart';
import '../../../global/widgets/drop_shadow.dart';
import '../../../global/widgets/variant_progress_button.dart';
import '../controllers/appointments_controller.dart';
import '../../../global/widgets/avatar.dart';

class AppointmentsView extends GetResponsiveView<AppointmentsController> {
  AppointmentsView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: NestedScrollView(
          headerSliverBuilder: (context, i) => [
                SliverToBoxAdapter(
                  child: Container(
                      // padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: SafeArea(
                        child: Text(
                          "Appointments",
                          style: Get.theme.textTheme.titleMedium,
                        ),
                      )),
                )
              ],
          body: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Obx(() => TableCalendar(
                      focusedDay: controller.focusedDay.value,
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      calendarFormat: controller.calenderFormat.value,
                      selectedDayPredicate: (day) =>
                          isSameDay(controller.selectedDay.value, day),
                      onFormatChanged: (format) {
                        controller.calenderFormat.value = format;
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.selectedDay.value = selectedDay;
                        controller.focusedDay.value = focusedDay;
                      },
                      onPageChanged: (focusedDay) {
                        controller.focusedDay.value = focusedDay;
                      },
                    )),
                if (controller.selectedDay.value != null)
                  Flexible(
                      child: DefaultTabController(
                    length: controller.timeslots.length + 1,
                    child: Column(
                      children: [
                        TabBar(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          indicatorSize: TabBarIndicatorSize.tab,
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return states.contains(MaterialState.focused)
                                  ? null
                                  : Colors.transparent;
                            },
                          ),
                          indicatorColor:
                              Get.theme.colorScheme.onPrimary.withOpacity(0.8),
                          unselectedLabelColor: Get
                              .theme.colorScheme.onBackground
                              .withOpacity(0.7),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: VariantTheme.primary.color,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: VariantTheme.primary.shadowColor,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1))
                            ],
                          ),
                          isScrollable: true,
                          tabs: [
                            ...(controller.timeslots.map((timeslot) => Tab(
                                  child: Text(
                                      "${timeslot.startTime12} - ${timeslot.endTime12}"),
                                ))),
                            Tab(
                              child: Text("Other"),
                            ),
                          ],
                        ),
                        Flexible(
                          child: TabBarView(children: [
                            ...(controller.timeslots.map(
                              (timeslot) => DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        labelColor:
                                            Get.theme.colorScheme.onBackground,
                                        indicatorColor:
                                            Get.theme.colorScheme.primary,
                                        tabs: [
                                          Tab(
                                            child: Text("UnVisited"),
                                          ),
                                          Tab(
                                            child: Text("Visited"),
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                          child: TabBarView(
                                        children: [
                                          _appointmentsPanel(
                                              timeslot: timeslot),
                                          _appointmentsPanel(
                                              timeslot: timeslot,
                                              isVisited: true)
                                        ],
                                      ))
                                    ],
                                  )),
                            )),
                            DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    TabBar(
                                      labelColor:
                                          Get.theme.colorScheme.onBackground,
                                      indicatorColor:
                                          Get.theme.colorScheme.primary,
                                      tabs: [
                                        Tab(
                                          child: Text("UnVisited"),
                                        ),
                                        Tab(
                                          child: Text("Visited"),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                        child: TabBarView(
                                      children: [
                                        _appointmentsPanel(
                                            timeslot: TimeslotModel()),
                                        _appointmentsPanel(
                                            timeslot: TimeslotModel(),
                                            isVisited: true)
                                      ],
                                    ))
                                  ],
                                )),
                          ]),
                        ),
                      ],
                    ),
                  ))
              ],
            ),
          )),
    ));
  }

  _appointmentsPanel(
          {bool isVisited = false, required TimeslotModel timeslot}) =>
      FutureBuilder<List<Map<String, FirestoreModel>>>(
          future: controller.getAppointments(
              isVisited: isVisited, timeslot: timeslot),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.hasData &&
                (snapshot.data == null || snapshot.data!.isEmpty)) {
              return Center(child: Text("No Appointments"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: dSpace / 2, vertical: dSpace),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screen.isDesktop
                      ? 3
                      : screen.isTablet
                          ? 2
                          : 1,
                  crossAxisSpacing: dSpace,
                  mainAxisSpacing: dSpace,
                  mainAxisExtent: 100,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final person = snapshot.data![index]["person"] as PersonModel;
                  final appointment =
                      snapshot.data![index]["appointment"] as AppointmentModel;
                  final timeslot =
                      snapshot.data![index]["timeslot"] as TimeslotModel;
                  return DropShadow(
                    child: Padding(
                      padding: EdgeInsets.all(dSpace * 0 / 2),
                      child: DropShadow(
                        blurRadius: dSpace / 2,
                        shadowOpacity: 0.1,
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(dSpace / 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius),
                              color: Get.theme.colorScheme.background,
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Avatar(
                                    person.image!,
                                    size: 70,
                                  ),
                                  SizedBox(
                                    width: dSpace / 2,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                person.name!,
                                                style: Get.theme.textTheme
                                                    .titleMedium,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            person.email!,
                                            style: Get.theme.textTheme.caption,
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            person.phone!,
                                            style: Get.theme.textTheme.caption,
                                          ),
                                          if (appointment.isVisited)
                                            Text(
                                              "Visited at " +
                                                  DateFormat.yMd()
                                                      .add_jm()
                                                      .format(appointment
                                                          .visited_at!),
                                              style:
                                                  Get.theme.textTheme.caption,
                                            )
                                        ]),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          });
}

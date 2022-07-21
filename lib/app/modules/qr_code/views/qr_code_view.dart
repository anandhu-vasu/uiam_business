import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uiam_business/app/data/models/appointment_model.dart';
import 'package:uiam_business/app/data/models/person_model.dart';
import 'package:uiam_business/app/data/models/timeslot_model.dart';
import 'package:uiam_business/app/data/providers/appointment_provider.dart';
import 'package:uiam_business/app/global/widgets/variant_button.dart';
import 'package:uiam_business/app/routes/app_pages.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';
import 'package:uiam_business/main.dart';
import '../../../../core/values/consts.dart';
import '../../../../core/values/strings.dart';
import '../../../data/models/firestore_model.dart';
import '../../../global/widgets/avatar.dart';
import '../../../global/widgets/drop_shadow.dart';
import '../../../global/widgets/variant_progress_button.dart';
import '../controllers/qr_code_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QrCodeView extends GetView<QrCodeController> {
  const QrCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.colorScheme.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appNameShort,
              style: TextStyle(
                color: Get.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Text(
              appFor.toUpperCase(),
              style: TextStyle(
                color: Get.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: dSpace,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 320,
                  width: 280,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  child: MobileScanner(
                      allowDuplicates: false,
                      fit: BoxFit.cover,
                      controller: controller.qrCodeController,
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                        } else {
                          final String pid = barcode.rawValue!;
                          print("########     $pid ");
                          controller.qrCodeController.stop();
                          Get.bottomSheet(_bottomSheet(pid),
                              isDismissible: false,
                              enableDrag: false,
                              backgroundColor: Get.theme.colorScheme.background,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)));
                        }
                      }),
                )
              ],
            ),
            SizedBox(
              height: dSpace,
            ),
            Text(
              controller.auth.user.name!,
              style: Get.theme.textTheme.titleLarge?.copyWith(
                color: Get.theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ));
  }

  _bottomSheet(String pid) {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);
    return SizedBox(
      height: Get.height,
      child: FutureBuilder<Map<String, FirestoreModel>>(
          future: controller.getAppointment(pid, date),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Text("Somthing went wrong",
                            style: Get.theme.textTheme.titleLarge
                                ?.copyWith(color: VariantTheme.danger.color))),
                    SizedBox(
                      height: dSpace / 2,
                    ),
                    VariantButton(
                      content: "Cancel",
                      width: 100,
                      theme: VariantTheme.light,
                      onTap: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                    ),
                  ]);
              ;
            }

            if (snapshot.hasData &&
                (snapshot.data == null || snapshot.data!.isEmpty)) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Text("Not Found",
                            style: Get.theme.textTheme.titleLarge
                                ?.copyWith(color: VariantTheme.danger.color))),
                    SizedBox(
                      height: dSpace / 2,
                    ),
                    VariantButton(
                      content: "Cancel",
                      width: 100,
                      theme: VariantTheme.light,
                      onTap: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                    ),
                  ]);
              ;
            }

            if (snapshot.connectionState == ConnectionState.done) {
              final appointment =
                  snapshot.data!["appointment"] as AppointmentModel;
              final person = snapshot.data!["person"] as PersonModel;
              final timeslot = snapshot.data!["timeslot"] as TimeslotModel;
              if (person.id == null) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Text("Invalid Code",
                              style: Get.theme.textTheme.titleLarge?.copyWith(
                                  color: VariantTheme.danger.color))),
                      SizedBox(
                        height: dSpace / 2,
                      ),
                      VariantButton(
                        content: "Cancel",
                        width: 100,
                        theme: VariantTheme.light,
                        onTap: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                      ),
                    ]);
              }

              if (appointment.id == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Text(
                      "No Appointment Found",
                      style: TextStyle(color: VariantTheme.danger.color),
                    )),
                    SizedBox(
                      height: dSpace / 2,
                    ),
                    _personTile(person),
                    SizedBox(
                      height: dSpace / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VariantButton(
                          content: "Cancel",
                          width: 100,
                          theme: VariantTheme.light,
                          onTap: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                        ),
                        SizedBox(
                          width: dSpace,
                        ),
                        VariantProgressButton(
                          onCompleted: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          content: "Accept",
                          width: 100,
                          onTap: () async {
                            return await AppointmentProvider(null).create(
                                model: AppointmentModel(
                                    bid: controller.auth.uid,
                                    pid: pid,
                                    date: date,
                                    isVisited: true),
                                data: {
                                  "visited_at": FieldValue.serverTimestamp()
                                });
                          },
                        ),
                      ],
                    )
                  ],
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text(
                    "Appointment Found",
                    style: TextStyle(color: VariantTheme.success.color),
                  )),
                  SizedBox(
                    height: dSpace / 2,
                  ),
                  if (timeslot.id != null)
                    VariantButton(
                      content:
                          "${timeslot.startTime12} - ${timeslot.endTime12}",
                      width: hSize,
                    ),
                  SizedBox(
                    height: dSpace / 2,
                  ),
                  _personTile(person),
                  SizedBox(
                    height: dSpace / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariantButton(
                        content: "Cancel",
                        width: 100,
                        theme: VariantTheme.light,
                        onTap: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                      ),
                      SizedBox(
                        width: dSpace,
                      ),
                      VariantProgressButton(
                        onCompleted: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                        content: "Accept",
                        width: 100,
                        onTap: () async {
                          return await AppointmentProvider(appointment.id).save(
                              model: AppointmentModel(isVisited: true),
                              data: {
                                "visited_at": FieldValue.serverTimestamp()
                              });
                        },
                      ),
                    ],
                  )
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            );
          })),
    );
  }

  _personTile(PersonModel person) => Padding(
        padding: const EdgeInsets.all(dSpace / 2),
        child: DropShadow(
          blurRadius: dSpace / 2,
          shadowOpacity: 0.1,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                person.name!,
                                style: Get.theme.textTheme.titleMedium,
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
                        ]),
                  )
                ]),
          ),
        ),
      );
}

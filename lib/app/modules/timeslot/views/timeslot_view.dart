import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uiam_business/app/data/enums/variant_button_size.dart';
import 'package:uiam_business/app/data/models/timeslot_model.dart';
import 'package:uiam_business/app/data/providers/firestore_provider.dart';
import 'package:uiam_business/app/data/providers/timeslot_provider.dart';
import 'package:uiam_business/app/global/widgets/drop_shadow.dart';
import 'package:uiam_business/app/global/widgets/variant_button.dart';
import 'package:uiam_business/app/global/widgets/variant_progress_button.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';
import 'package:uiam_business/core/values/consts.dart';

import '../controllers/timeslot_controller.dart';

class TimeslotView extends GetResponsiveView<TimeslotController> {
  TimeslotView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_rounded),
          onPressed: () {
            Get.bottomSheet(
                cuTimeslot(TimeslotModel(bid: controller.auth.uid)));
          },
        ),
        body: Scrollbar(
            child: NestedScrollView(
          headerSliverBuilder: (context, i) => [
            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: SafeArea(
                    child: Text(
                      "Timeslots",
                      style: Get.theme.textTheme.titleMedium,
                    ),
                  )),
            )
          ],
          body: FirestoreQueryBuilder<Map<String, dynamic>>(
            query: TimeslotProvider(null)
                .collectionRef()
                .where('bid', isEqualTo: controller.auth.uid),
            builder: (context, snapshot, _) {
              if (snapshot.docs.length == 0) {
                return Center(child: Text("No Timeslotes"));
              }

              controller.timeslots = snapshot.docs
                  .map((documentSnapshot) =>
                      TimeslotModel.fromDocumentSnapshot(documentSnapshot))
                  .toList();

              return GridView.builder(
                clipBehavior: Clip.none,
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
                  mainAxisExtent: 150,
                ),
                itemCount: snapshot.docs.length,
                itemBuilder: (context, index) {
                  // if we reached the end of the currently obtained items, we try to
                  // obtain more items
                  if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                    // Tell FirestoreQueryBuilder to try to obtain more items.
                    // It is safe to call this function from within the build method.
                    snapshot.fetchMore();
                  }

                  final timeslot = controller.timeslots[index];

                  return DropShadow(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: dSpace / 2),
                      decoration: BoxDecoration(
                          color: Get.theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(borderRadius)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              VariantButton(
                                content: timeslot.startTime12,
                                width: hSize / 2,
                              ),
                              VariantButton(
                                content: timeslot.endTime12,
                                width: hSize / 2,
                              )
                            ],
                          ),
                          SizedBox(
                            height: dSpace / 2,
                          ),
                          Text(
                            "Capacity: ${timeslot.capacity}",
                            style: Get.theme.textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: dSpace / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VariantButton(
                                content: Icons.edit_note_rounded,
                                circular: true,
                                theme: VariantTheme.warning,
                                onTap: () {
                                  Get.bottomSheet(cuTimeslot(timeslot));
                                },
                              ),
                              SizedBox(
                                width: dSpace / 2,
                              ),
                              VariantProgressButton(
                                content: Icons.delete_rounded,
                                circular: true,
                                theme: VariantTheme.danger,
                                onTap: () async {
                                  await TimeslotProvider(timeslot.id).delete();
                                  return null;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )));
  }

  Widget cuTimeslot(TimeslotModel timeslotModel) {
    TimeslotModel timeslot = timeslotModel;
    final GlobalKey<FormState> _timeslotFormKey = GlobalKey<FormState>();

    return Container(
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.background,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadius))),
      padding: EdgeInsets.all(dSpace / 2),
      child: Form(
          key: _timeslotFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: dSpace,
                runSpacing: dSpace,
                children: [
                  DropShadow(
                    child: DateTimePicker(
                      type: DateTimePickerType.time,
                      timeLabelText: "Start Time",
                      initialValue: timeslot.startTime,
                      validator: (value) {
                        if (GetUtils.isNullOrBlank(value)!) {
                          return 'Please enter start time';
                        }

                        return null;
                      },
                      onSaved: (value) =>
                          timeslot = timeslot.copyWith(startTime: value!),
                    ),
                  ),
                  DropShadow(
                    child: DateTimePicker(
                      initialValue: timeslot.endTime,
                      type: DateTimePickerType.time,
                      timeLabelText: "End Time",
                      validator: (value) {
                        if (GetUtils.isNullOrBlank(value)!) {
                          return 'Please enter end time';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          timeslot = timeslot.copyWith(endTime: value!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: dSpace),
              TextFormField(
                initialValue: timeslot.capacity?.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    timeslot = timeslot.copyWith(capacity: int.parse(value!)),
                validator: (value) {
                  if (GetUtils.isNullOrBlank(value)!) {
                    return 'Please enter timeslot capacity';
                  }
                  final i = int.tryParse(value!);
                  if (i == null || i <= 0) {
                    return 'Capacity should be a number greater than 0';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: "Capacity"),
              ),
              SizedBox(
                height: dSpace,
              ),
              VariantProgressButton(
                onTap: () async {
                  if (_timeslotFormKey.currentState != null &&
                      _timeslotFormKey.currentState!.validate()) {
                    _timeslotFormKey.currentState!.save();

                    if (timeslot.isConflictWithAny(controller.timeslots)) {
                      Get.snackbar("Timeslot Conflict",
                          "Change start time and end time to avoid conflict");
                      return null;
                    }

                    if (timeslot.id == null) {
                      return await TimeslotProvider(null)
                          .create(model: timeslot);
                    } else {
                      return await TimeslotProvider(timeslot.id)
                          .save(model: timeslot);
                    }
                  }
                },
                onCompleted: () {
                  Get.back();
                },
                content: timeslot.id == null ? "Create" : "Save",
                width: 100,
              )
            ],
          )),
    );
  }
}

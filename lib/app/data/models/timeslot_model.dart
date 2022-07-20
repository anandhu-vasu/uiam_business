import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uiam_business/app/data/models/firestore_model.dart';
import 'package:uiam_business/app/utils/helpers/json_converters.dart';

part 'generated/timeslot_model.freezed.dart';
part 'generated/timeslot_model.g.dart';

@freezed
class TimeslotModel extends FirestoreModel with _$TimeslotModel {
  TimeslotModel._();

  factory TimeslotModel(
      {String? id,
      String? bid,
      @JsonKey(name: 'start_time')
          String? startTime,
      @JsonKey(name: 'end_time')
          String? endTime,
      int? capacity,
      @JsonKey(fromJson: firestoreTimeStampToDateTime)
          DateTime? created_at}) = _TimeslotModel;

  factory TimeslotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeslotModelFromJson(json);

  factory TimeslotModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return TimeslotModel.fromJson(
        FirestoreModel.documentSnapshotToJson(documentSnapshot));
  }

  String _twelveHourVal(String inputString) {
    var splitTime = inputString.split(":");
    int hour = int.parse(splitTime[0]);
    String suffix = "AM";
    if (hour > 12) {
      hour -= 12;
      suffix = "PM";
    } else if (hour == 0) {
      hour = 12;
      suffix = "AM";
    } else if (hour == 12) {
      hour = 12;
      suffix = "PM";
    }

    String twelveHourVal = '$hour:${splitTime[1]} $suffix';
    return twelveHourVal;
  }

  double _toDouble(String timeString) {
    final st = timeString.split(":");
    return int.parse(st[0]) + int.parse(st[1]) / 60.0;
  }

  String get startTime12 => _twelveHourVal(startTime!);
  String get endTime12 => _twelveHourVal(endTime!);

  bool isConflictWith(TimeslotModel t) => (startTime != null &&
      endTime != null &&
      (_toDouble(startTime!) <= _toDouble(t.endTime!) &&
          _toDouble(t.startTime!) <= _toDouble(endTime!)));

  bool isConflictWithAny(List<TimeslotModel> timeslots) {
    for (final t in timeslots) {
      if (id != t.id && isConflictWith(t)) {
        return true;
      }
    }
    return false;
  }

  int compareWith(TimeslotModel t) {
    if (startTime == t.startTime) {
      return 0;
    } else if (_toDouble(startTime!) > _toDouble(t.startTime!)) {
      return 1;
    } else {
      return -1;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uiam_business/app/data/models/firestore_model.dart';
import 'package:uiam_business/app/utils/helpers/json_converters.dart';

part 'generated/appointment_model.freezed.dart';
part 'generated/appointment_model.g.dart';

@freezed
class AppointmentModel extends FirestoreModel with _$AppointmentModel {
  AppointmentModel._();

  factory AppointmentModel(
      {String? id,
      String? bid,
      String? pid,
      @JsonKey(name: "timeslot_id")
          String? timeslotId,
      DateTime? date,
      @JsonKey(name: "is_visited")
      @Default(false)
          bool isVisited,
      @JsonKey(fromJson: firestoreTimeStampToDateTime)
          DateTime? visited_at,
      @JsonKey(fromJson: firestoreTimeStampToDateTime)
          DateTime? created_at}) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  factory AppointmentModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return AppointmentModel.fromJson(
        FirestoreModel.documentSnapshotToJson(documentSnapshot));
  }
}

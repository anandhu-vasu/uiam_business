import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, int> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(int minutes) =>
      TimeOfDay(hour: (minutes / 60).floor(), minute: minutes % 60);

  @override
  int toJson(TimeOfDay time) => time.hour * 60 + time.minute;
}

DateTime? firestoreTimeStampToDateTime(Timestamp timestamp) =>
    timestamp == null ? null : DateTime.parse(timestamp.toDate().toString());

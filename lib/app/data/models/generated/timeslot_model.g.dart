// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../timeslot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimeslotModel _$$_TimeslotModelFromJson(Map<String, dynamic> json) =>
    _$_TimeslotModel(
      id: json['id'] as String?,
      bid: json['bid'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      capacity: json['capacity'] as int?,
      created_at: firestoreTimeStampToDateTime(json['created_at']),
    );

Map<String, dynamic> _$$_TimeslotModelToJson(_$_TimeslotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bid': instance.bid,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'capacity': instance.capacity,
      'created_at': instance.created_at?.toIso8601String(),
    };

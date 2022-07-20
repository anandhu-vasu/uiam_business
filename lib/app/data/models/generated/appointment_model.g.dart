// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppointmentModel _$$_AppointmentModelFromJson(Map<String, dynamic> json) =>
    _$_AppointmentModel(
      id: json['id'] as String?,
      bid: json['bid'] as String?,
      pid: json['pid'] as String?,
      timeslotId: json['timeslot_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      isVisited: json['is_visited'] as bool? ?? false,
      visited_at: firestoreTimeStampToDateTime(json['visited_at']),
      created_at: firestoreTimeStampToDateTime(json['created_at']),
    );

Map<String, dynamic> _$$_AppointmentModelToJson(_$_AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bid': instance.bid,
      'pid': instance.pid,
      'timeslot_id': instance.timeslotId,
      'date': instance.date?.toIso8601String(),
      'is_visited': instance.isVisited,
      'visited_at': instance.visited_at?.toIso8601String(),
      'created_at': instance.created_at?.toIso8601String(),
    };

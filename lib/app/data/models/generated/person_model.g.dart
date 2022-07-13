// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PersonModel _$$_PersonModelFromJson(Map<String, dynamic> json) =>
    _$_PersonModel(
      id: json['id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['date_of_brith'] == null
          ? null
          : DateTime.parse(json['date_of_brith'] as String),
      address: json['address'] as String?,
      place: json['place'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postal_code'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$_PersonModelToJson(_$_PersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'date_of_brith': instance.dateOfBirth?.toIso8601String(),
      'address': instance.address,
      'place': instance.place,
      'city': instance.city,
      'state': instance.state,
      'postal_code': instance.postalCode,
      'country': instance.country,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusinessModel _$$_BusinessModelFromJson(Map<String, dynamic> json) =>
    _$_BusinessModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      description: json['description'] as String?,
      location: _locationFromJson(json['location'] as Map<String, dynamic>?),
      address: json['address'] as String?,
      place: json['place'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postal_code'] as String?,
    );

Map<String, dynamic> _$$_BusinessModelToJson(_$_BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'image': instance.image,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'description': instance.description,
      'location': _locationToJson(instance.location),
      'address': instance.address,
      'place': instance.place,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postal_code': instance.postalCode,
    };

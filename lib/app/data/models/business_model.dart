import 'package:uiam_business/app/data/models/firestore_model.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'generated/business_model.freezed.dart';
part 'generated/business_model.g.dart';

@freezed
class BusinessModel extends FirestoreModel with _$BusinessModel {
  BusinessModel._();

  factory BusinessModel({
    final String? id,
    final String? name,
    final String? type,
    final String? image,
    final String? email,
    final String? phone,
    final String? website,
    final String? description,
    @JsonKey(fromJson: _locationFromJson, toJson: _locationToJson)
        final GeoFirePoint? location,
    final String? address,
    final String? place,
    final String? city,
    final String? state,
    final String? country,
    @JsonKey(name: 'postal_code') final String? postalCode,
  }) = _BusinessModel;

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  factory BusinessModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return BusinessModel.fromJson(
        FirestoreModel.documentSnapshotToJson(documentSnapshot));
  }
}

_locationFromJson(Map<String, dynamic>? json) {
  return json == null
      ? null
      : GeoFirePoint(
          json['geopoint'].latitude as double,
          json['geopoint'].longitude as double,
        );
}

_locationToJson(GeoFirePoint? location) {
  return location?.data;
}

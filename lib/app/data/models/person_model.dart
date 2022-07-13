import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uiam_business/app/data/models/firestore_model.dart';

part 'generated/person_model.freezed.dart';
part 'generated/person_model.g.dart';

@freezed
class PersonModel extends FirestoreModel with _$PersonModel {
  PersonModel._();

  factory PersonModel({
    String? id,
    String? image,
    String? name,
    String? email,
    String? phone,
    @JsonKey(name: 'date_of_brith') DateTime? dateOfBirth,
    String? address,
    String? place,
    String? city,
    String? state,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? country,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);

  factory PersonModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return PersonModel.fromJson(
        FirestoreModel.documentSnapshotToJson(documentSnapshot));
  }
}



// final String? id;
//   final String? name;
//   final String? image;
//   final String? email;
//   final String? phone;
//   final String? address;
//   final String? city;
//   final String? state;
//   final String? country;
//   final String? postalCode;
//   final DateTime? dateOfBirth;

//   PersonModel({
//     this.id,
//     this.name,
//     this.image,
//     this.email,
//     this.phone,
//     this.address,
//     this.city,
//     this.state,
//     this.country,
//     this.postalCode,
//     this.dateOfBirth,
//   });

//   factory PersonModel.fromJson(Map<String, dynamic> json) =>
//       _$PersonModelFromJson(json);

//   Map<String, dynamic> toJson() => _$PersonModelToJson(this);

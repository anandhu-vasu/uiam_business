import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreModel {
  Map<String, dynamic> toJson();

  Map<String, dynamic> toData() {
    Map<String, dynamic> _data = this.toJson();
    _data.removeWhere((key, value) =>
        value == null ||
        key == "id" ||
        key == "updated_at" ||
        key == "created_at");
    return _data;
  }

  static Map<String, dynamic> documentSnapshotToJson(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    Map<String, dynamic>? map = documentSnapshot.data();
    return map != null ? {"id": documentSnapshot.id, ...map} : {};
  }
}

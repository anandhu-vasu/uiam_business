import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firestore_model.dart';

abstract class FirestoreProvider<T extends FirestoreModel> {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  final String? docId;

  FirestoreProvider(this.docId);

  /// Define collection for FirestoreService
  CollectionReference<Map<String, dynamic>> collectionRef();

  /// Define constructor for creating FirestoreModel from DocumentSnapshot
  T modelRef(DocumentSnapshot<Map<String, dynamic>> documentSnapshot);

  /// Stream a document with [docId] from the collection
  Stream<T> stream(
      {CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?}) {
    try {
      return (newCollectionRef != null
              ? newCollectionRef(collectionRef(), docId)
              : collectionRef())
          .doc(docId)
          .snapshots()
          .map<T>((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
              modelRef(documentSnapshot));
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::STREAM=== $e");
      rethrow;
    }
  }

  /// Get a document with [docId] from the collection
  Future<T> fetch(
      {CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await (newCollectionRef != null
                  ? newCollectionRef(collectionRef(), docId)
                  : collectionRef())
              .doc(docId)
              .get();

      print('###DATA<$T>: ${documentSnapshot.data()}');
      return this.modelRef(documentSnapshot);
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::FETCH=== $e");
      rethrow;
    }
  }

  /// Stream all documents from the collection
  Stream<Iterable<T>> streamAll(
      {Query<Map<String, dynamic>> query(
          Query<Map<String, dynamic>> ref, String? docId)?}) {
    try {
      return (query != null ? query(collectionRef(), docId) : collectionRef())
          .snapshots()
          .map<Iterable<T>>((QuerySnapshot<Map<String, dynamic>>
                  querySnapshot) =>
              querySnapshot.docs.map<T>(
                  (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
                      modelRef(documentSnapshot)));
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::STREAM_ALL=== $e");
      rethrow;
    }
  }

  /// Get all documents from the collection
  Future<Iterable<T>> fetchAll(
      {Query<Map<String, dynamic>> query(
          Query<Map<String, dynamic>> ref, String? docId)?}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await (query != null
              ? query(collectionRef(), docId)
              : collectionRef())
          .get();

      return querySnapshot.docs.map(
          (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
              modelRef(documentSnapshot));
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::FETCH_ALL=== $e");
      rethrow;
    }
  }

  /// Create a new document with random id and @param model
  Future<bool> create(
      {required T model,
      CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?,
      Map<String, dynamic>? data}) async {
    try {
      await (newCollectionRef != null
              ? newCollectionRef(collectionRef(), docId)
              : collectionRef())
          .add({
        ...model.toData(),
        ...?data,
        "created_at": FieldValue.serverTimestamp(),
        "updated_at": FieldValue.serverTimestamp()
      });

      return true;
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::CREATE=== $e");
      return false;
    }
  }

  /// Set document fields using @param model
  Future<bool> save(
      {required T model,
      CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?,
      Map<String, dynamic>? data}) async {
    try {
      await (newCollectionRef != null
              ? newCollectionRef(collectionRef(), docId)
              : collectionRef())
          .doc(docId)
          .set({
        ...model.toData(),
        ...?data,
        "updated_at": FieldValue.serverTimestamp()
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::SAVE=== $e");
      return false;
    }
  }

  /// Increment (value > 0) or Decrement (value < 0) @param field with @param value
  Future<void> increment(String field, int value,
      {CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?}) async {
    try {
      await (newCollectionRef != null
              ? newCollectionRef(collectionRef(), docId)
              : collectionRef())
          .doc(docId)
          .update({field: FieldValue.increment(value)});
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::INCREMENT=== $e");
      rethrow;
    }
  }

  Future<void> delete(
      {CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?}) async {
    try {
      await (newCollectionRef != null
              ? newCollectionRef(collectionRef(), docId)
              : collectionRef())
          .doc(docId)
          .delete();
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::SAVE=== $e");
      rethrow;
    }
  }

  String newDocId(
      {CollectionReference<Map<String, dynamic>> newCollectionRef(
          CollectionReference<Map<String, dynamic>> collectionRef,
          String? docId)?}) {
    try {
      return (newCollectionRef != null
              ? newCollectionRef(collectionRef(), docId)
              : collectionRef())
          .doc()
          .id;
    } catch (e) {
      print("===FIRESTORE_SERVICE|ERROR<$T>::CREATE_ID=== $e");
      rethrow;
    }
  }
}

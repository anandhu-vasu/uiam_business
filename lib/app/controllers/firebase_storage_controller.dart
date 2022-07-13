import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final uploadPercent = 0.0.obs;
  final isUploading = false.obs;

  void upload(String storagePath, CroppedFile file,
      {String? mimeType,
      Function(String)? onComplete,
      Function(dynamic)? onError}) async {
    Stream<TaskSnapshot> stream;

    Reference ref = _storage.ref().child(storagePath);

    final metadata = SettableMetadata(
      contentType: mimeType,
      customMetadata: {'picked-file-path': file.path},
    );

    stream = ref.putData(await file.readAsBytes(), metadata).snapshotEvents;

    stream.listen((TaskSnapshot snapshot) async {
      print('Task state: ${snapshot.state}');
      if (snapshot.state == TaskState.running) {
        uploadPercent.value = (snapshot.bytesTransferred / snapshot.totalBytes);
        print(
            'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
        isUploading.value = true;
      } else {
        if (snapshot.state == TaskState.success) {
          final url = await snapshot.ref.getDownloadURL();
          onComplete?.call(url);
        }
        isUploading.value = false;
        uploadPercent.value = 0.0;
      }
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }

      if (e.code == 'network-error') {
        print('Network error occurred.');
      }

      if (e.code == 'storage-error') {
        print('Storage error occurred.');
      }

      onError?.call(e);

      Future.delayed(250.milliseconds, () {
        isUploading.value = false;
        uploadPercent.value = 0.0;
      });
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}

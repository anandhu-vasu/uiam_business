import 'package:get/get.dart';

import '../../../controllers/firebase_storage_controller.dart';
import '../controllers/business_profile_form_controller.dart';

class BusinessProfileFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessProfileFormController>(
      () => BusinessProfileFormController(),
    );

    Get.lazyPut<FirebaseStorageController>(() => FirebaseStorageController());
  }
}

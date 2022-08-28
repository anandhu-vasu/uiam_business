import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uiam_business/app/data/models/business_model.dart';
import 'package:uiam_business/app/services/auth_service.dart';
import '../../../data/providers/business_provider.dart';
import '../../../utils/helpers/cropper/ui_helper.dart'
    if (dart.library.io) '../../../utils/helpers/cropper/mobile_ui_helper.dart'
    if (dart.library.html) '../../../utils/helpers/cropper/web_ui_helper.dart';
import '../../../controllers/firebase_storage_controller.dart';

class BusinessProfileFormController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GlobalKey<FormState> infoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  late final tabController = TabController(length: 2, vsync: this);

  final AuthService auth = Get.find<AuthService>();

  final hashingvalue = "qwertyuiopasdfghjklzxcvbnm";
  bool success = false;

  BusinessModel business = BusinessModel();
  late BusinessProvider personProvider;

  final imagePath = ''.obs;

  bool isInfoSave = false;
  final marker = Rxn<Marker>(null);
  final locationController = TextEditingController();
  final storageController = Get.find<FirebaseStorageController>();
  LatLng? initialMapCenter;

  @override
  void onInit() async {
    personProvider = BusinessProvider(auth.uid);
    business = auth.user;
    if (auth.user.phone == null) {
      business = business.copyWith(phone: auth.firebaseUser!.phoneNumber);
    }
    if (business.location != null) {
      locationController.text =
          "${business.location!.latitude}, ${business.location!.longitude}";
      final loc =
          LatLng(business.location!.latitude, business.location!.longitude);
      onLocationSelect(loc);
      initialMapCenter = loc;
    }
    initialMapCenter ??= await _determinePosition();
    imagePath.value = business.image ?? '';
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  Future<CroppedFile?> cropImage(String path) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxHeight: 128,
      maxWidth: 128,
      cropStyle: CropStyle.rectangle,
      uiSettings: buildUiSettings(Get.context!),
    );

    return croppedImage;
  }

  Future<void> selectImage(ImageSource source) async {
    final _pickedImage =
        await ImagePicker().pickImage(source: source, imageQuality: 75);

    if (_pickedImage != null) {
      CroppedFile? croppedFile = await cropImage(_pickedImage.path);

      if (croppedFile != null) {
        imagePath.value = croppedFile.path;
        storageController.upload("images/${auth.uid}/avatar", croppedFile,
            mimeType: _pickedImage.mimeType, onComplete: (url) {
          imagePath.value = url;
        });
      }
    }
  }

  onLocationSelect(LatLng latlng) {
    marker.value = Marker(
      width: 80.0,
      height: 80.0,
      point: latlng,
      builder: (ctx) => Transform.translate(
          offset: Offset(0, -20),
          child: Icon(
            Icons.location_on,
            size: 40,
            color: Get.theme.colorScheme.primary,
          )),
    );
  }

  Future<LatLng> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //  Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var data = await Geolocator.getCurrentPosition();
    return LatLng(data.latitude, data.longitude);
  }
}

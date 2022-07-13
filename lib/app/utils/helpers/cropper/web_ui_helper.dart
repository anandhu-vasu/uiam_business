import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:uiam_business/app/global/widgets/variant_button.dart';

List<PlatformUiSettings>? buildUiSettings(BuildContext context) {
  return [
    WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: Boundary(
        width: 375,
        height: 375,
      ),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    ),
  ];
}

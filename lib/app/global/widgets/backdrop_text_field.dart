import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/values/consts.dart';
import 'drop_shadow.dart';

class BackdropTextField extends StatelessWidget {
  final IconData? icon;
  final String? hintText;
  final String? prefixText;
  final double? width;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final TextAlign textAlign;
  final int? maxLength;

  const BackdropTextField(
      {Key? key,
      this.icon,
      this.hintText,
      this.prefixText,
      this.controller,
      this.width,
      this.onChanged,
      this.inputFormatter,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return DropShadow(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 15,
            sigmaX: 15,
          ),
          child: Container(
            height: vSize,
            width: width ?? hSize,
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: size.width / 30),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.onBackground.withOpacity(.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              inputFormatters: inputFormatter,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              obscureText: obscureText,
              textAlign: textAlign,
              maxLength: maxLength,
              style: TextStyle(
                  color: Get.theme.colorScheme.onBackground.withOpacity(.8)),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                filled: false,
                prefixIcon: Icon(
                  icon,
                  color: Get.theme.colorScheme.onBackground.withOpacity(.7),
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Get.theme.colorScheme.onBackground.withOpacity(.5)),
                prefixText: prefixText,
                prefixStyle: TextStyle(
                  color: Get.theme.colorScheme.onBackground.withOpacity(.5),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

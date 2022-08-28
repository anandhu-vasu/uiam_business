import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

import 'drop_shadow.dart';

class Avatar extends StatelessWidget {
  String url;
  final double size;
  final double borderRadius;
  final double shadowOpacity;
  final Color? shadowColor;
  final double blurRadius;
  final double spreadRadius;
  Avatar(this.url,
      {Key? key,
      this.size = 80,
      this.borderRadius = 20,
      this.shadowOpacity = 0.30,
      this.shadowColor,
      this.blurRadius = 25,
      this.spreadRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: shadowColor ??
                  Theme.of(context).shadowColor.withOpacity(shadowOpacity),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Center(
            child: OctoImage(
                image: CachedNetworkImageProvider(url),
                progressIndicatorBuilder:
                    OctoProgressIndicator.circularProgressIndicator())),
      );
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/values/consts.dart';
import '../../data/enums/variant_button_size.dart';
import 'drop_shadow.dart';

class BackdropButton extends StatelessWidget {
  final dynamic content;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final VariantButtonSize size;
  final BorderRadius? borderRadius;
  final bool rounded;

  const BackdropButton(
      {Key? key,
      this.content,
      this.onTap,
      this.width,
      this.height,
      this.size = VariantButtonSize.medium,
      this.borderRadius,
      this.rounded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = height ?? size.height;
    final _width =
        width ?? ((content is IconData) ? (height ?? size.height) : null);
    final _borderRadius = borderRadius ??
        BorderRadius.circular(rounded ? _height : size.borderRadius);

    return DropShadow(
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: Container(
            height: _height,
            width: _width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.onBackground.withOpacity(.05),
              borderRadius: _borderRadius,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor:
                    Get.theme.colorScheme.onBackground.withOpacity(.25),
                onTap: onTap,
                borderRadius: _borderRadius,
                child: Center(
                  child: (content is String)
                      ? Text(
                          content,
                          style: TextStyle(
                              color: Get.theme.colorScheme.onBackground
                                  .withOpacity(.8)),
                        )
                      : ((content is IconData)
                          ? Icon(
                              content,
                              color: Get.theme.colorScheme.onBackground
                                  .withOpacity(.8),
                            )
                          : (content is Widget)
                              ? content
                              : Container()),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // return DropShadow(
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(15),
    //     child: BackdropFilter(
    //       filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
    //       child: InkWell(
    //         highlightColor: Colors.transparent,
    //         splashColor: Colors.transparent,
    //         onTap: onTap,
    //         borderRadius: _borderRadius,
    //         child: Container(
    //           height: _height,
    //           width: _width,
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             color: Get.theme.colorScheme.onBackground.withOpacity(.05),
    //             borderRadius: _borderRadius,
    //           ),
    //           child: (content is String)
    //               ? Text(
    //                   content,
    //                   style: TextStyle(
    //                       color: Get.theme.colorScheme.onBackground
    //                           .withOpacity(.8)),
    //                 )
    //               : ((content is IconData)
    //                   ? Icon(
    //                       content,
    //                       color: Get.theme.colorScheme.onBackground
    //                           .withOpacity(.8),
    //                     )
    //                   : (content is Widget)
    //                       ? content
    //                       : Container()),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

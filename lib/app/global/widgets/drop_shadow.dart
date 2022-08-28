import 'package:flutter/material.dart';
import '../../../core/values/colors.dart' as colors;
import '../../../core/values/consts.dart' as consts;

class DropShadow extends StatelessWidget {
  final Color? shadowColor;
  final double? blurRadius;
  final double? spreadRadius;
  final double? shadowOpacity;
  final BorderRadius? borderRadius;
  final Widget? child;
  const DropShadow(
      {Key? key,
      this.shadowColor,
      this.blurRadius,
      this.borderRadius,
      this.child,
      this.spreadRadius,
      this.shadowOpacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius:
            borderRadius ?? BorderRadius.circular(consts.borderRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor ??
                Theme.of(context)
                    .shadowColor
                    .withOpacity(shadowOpacity ?? 0.15),
            blurRadius: blurRadius ?? 55, //99,
            spreadRadius: spreadRadius ?? 0,
          ),
        ],
      ),
    );
  }
}

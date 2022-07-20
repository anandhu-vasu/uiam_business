import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/consts.dart';
import '../../../core/theme/variant_theme.dart';
import '../../data/enums/variant_button_size.dart';
import 'drop_shadow.dart';

class VariantButton extends StatelessWidget {
  final dynamic content;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final VariantColorScheme theme;
  final VariantButtonSize size;
  final BorderRadius? borderRadius;
  final bool circular;

  const VariantButton(
      {Key? key,
      this.content,
      this.onTap,
      this.width,
      this.theme = VariantTheme.primary,
      this.size = VariantButtonSize.medium,
      this.height,
      this.borderRadius,
      this.circular = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = height ?? size.height;
    final _width =
        width ?? ((content is IconData) ? (height ?? size.height) : null);
    final _borderRadius = borderRadius ??
        BorderRadius.circular(circular ? _height : size.borderRadius);

    return DropShadow(
      child: Container(
        height: _height,
        width: _width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.color,
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 2))
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: onTap,
            borderRadius: _borderRadius,
            child: Center(
              child: (content is String)
                  ? Text(
                      content,
                      style: TextStyle(color: theme.onColor.withOpacity(.8)),
                    )
                  : ((content is IconData)
                      ? Icon(
                          content,
                          color: theme.onColor.withOpacity(.8),
                        )
                      : (content is Widget)
                          ? content
                          : Container()),
            ),
          ),
        ),
      ),
    );
  }
}

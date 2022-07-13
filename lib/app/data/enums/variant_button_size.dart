import 'package:flutter/widgets.dart';

enum VariantButtonSize { xsmall, small, medium, large, xlarge }

extension VariantButtonSizeExtension on VariantButtonSize {
  double get height {
    switch (this) {
      case VariantButtonSize.xsmall:
        return 20.0;
      case VariantButtonSize.small:
        return 28.0;
      case VariantButtonSize.medium:
        return 36.0;
      case VariantButtonSize.large:
        return 44.0;
      case VariantButtonSize.xlarge:
        return 52.0;
    }
  }

  double get borderRadius {
    switch (this) {
      case VariantButtonSize.xsmall:
        return 4.0;
      case VariantButtonSize.small:
        return 6.0;
      case VariantButtonSize.medium:
        return 8.0;
      case VariantButtonSize.large:
        return 10.0;
      case VariantButtonSize.xlarge:
        return 12.0;
    }
  }
}

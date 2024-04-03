import 'package:flutter/material.dart';
import 'package:sen_s_application1/core/utils/size_utils.dart';
import 'package:sen_s_application1/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Label text style
  static get labelLargeGray40001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray40001,
      );
  static get labelLargeOnError => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onError,
      );
  static get labelMediumff000000 => theme.textTheme.labelMedium!.copyWith(
        color: Color(0XFF000000),
      );
}

extension on TextStyle {
  TextStyle get lexendExa {
    return copyWith(
      fontFamily: 'Lexend Exa',
    );
  }
}

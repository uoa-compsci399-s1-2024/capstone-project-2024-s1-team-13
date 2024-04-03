import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/utils/size_utils.dart';
import 'package:natania_s_application2/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Label text style
  static get labelLargeGray40001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray40001,
      );
  static get labelMediumff000000 => theme.textTheme.labelMedium!.copyWith(
        color: Color(0XFF000000),
      );
  // Title text style
  static get titleLargeOnError => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 22.fSize,
      );
  static get titleLargeOnError22 => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 22.fSize,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 19.fSize,
      );
  static get titleSmallGray40001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray40001,
      );
  static get titleSmallOnError => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onError,
      );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
}

extension on TextStyle {
  TextStyle get lexendExa {
    return copyWith(
      fontFamily: 'Lexend Exa',
    );
  }
}

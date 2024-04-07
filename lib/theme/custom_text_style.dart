import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/utils/size_utils.dart';
import 'package:istefat_s_application1/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Label text style
  static get labelMediumLexendDecaPink900 =>
      theme.textTheme.labelMedium!.lexendDeca.copyWith(
        color: appTheme.pink900,
        fontWeight: FontWeight.w500,
      );
  static get labelSmallRed30001 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.red30001,
        fontWeight: FontWeight.w800,
      );
  // Poppins text style
  static get poppinsOnPrimaryContainer => TextStyle(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w500,
      ).poppins;
  // Title text style
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 22.fSize,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleLargePink900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.pink900,
        fontSize: 20.fSize,
      );

  static get headlineMediumOnPrimary =>
      theme.textTheme.headlineMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLargeOnPrimaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get labelMediumPink900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.pink900,
      );
  static get labelMediumPrimary => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
      );
  static get labelSmallPink900 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.pink900,
      );
  // Title text style
  static get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 20.fSize,
      );
  
  static get labelLargeGray40001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray40001,
      );
  static get labelLargeOnError => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onError,
      );
  static get labelMediumff000000 => theme.textTheme.labelMedium!.copyWith(
        color: Color(0XFF000000),
      );
  static get labelLargeRed400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red400,
      );
  // Merge
  static get labelMediumPink900_1 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.pink900,
      );
  static get labelMediumff89375f => theme.textTheme.labelMedium!.copyWith(
        color: Color(0XFF89375F),
      );

  static get lexendExaWhiteA700 => TextStyle(
        color: appTheme.whiteA700,
        fontSize: 66.fSize,
        fontWeight: FontWeight.w500,
      ).lexendExa;

  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 22.fSize,
      );
  static get titleMedium19 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 19.fSize,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 19.fSize,
      );

  // Merge

  static get titleMediumPink900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.pink900,
      );

  
}


extension on TextStyle {
  TextStyle get lexendExa {
    return copyWith(
      fontFamily: 'Lexend Exa',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get lexend {
    return copyWith(
      fontFamily: 'Lexend',
    );
  }

  TextStyle get lexendDeca {
    return copyWith(
      fontFamily: 'Lexend Deca',
    );
  }
}

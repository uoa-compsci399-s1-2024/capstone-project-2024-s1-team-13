import 'package:flutter/material.dart';
import 'package:tetuhi/core/utils/size_utils.dart';
import 'package:tetuhi/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Headline text style
  static get headlineLargeLexendPrimaryContainer =>
      theme.textTheme.headlineLarge!.lexend.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 30.fSize,
        fontWeight: FontWeight.w800,
      );
  static get headlineLargePrimary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 30.fSize,
        fontWeight: FontWeight.w500,
      );
  static get headlineLargePrimaryMedium =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontWeight: FontWeight.w500,
      );
  static get headlineSmall24 => theme.textTheme.headlineSmall!.copyWith(
        fontSize: 24.fSize,
      );
  static get headlineSmallInterWhiteA700 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.whiteA700,
        fontSize: 24.fSize,
        fontWeight: FontWeight.w800,
      );
  static get headlineSmallWhiteA700 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 24.fSize,
      );
  // Label text style
  static get labelLargeLexendDecaPink900 =>
      theme.textTheme.labelLarge!.lexendDeca.copyWith(
        color: appTheme.pink900,
        fontWeight: FontWeight.w500,
      );
  static get labelMediumInterErrorContainer =>
      theme.textTheme.labelMedium!.inter.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumInterRed30001 =>
      theme.textTheme.labelMedium!.inter.copyWith(
        color: appTheme.red30001,
        fontWeight: FontWeight.w800,
      );
  static get labelMediumPink900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.pink900,
      );
  // Title text style
  static get titleLargeLexendDecaPrimary =>
      theme.textTheme.titleLarge!.lexendDeca.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
      );
  static get titleLargeLexendDecaWhiteA700 =>
      theme.textTheme.titleLarge!.lexendDeca.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleLargeWhiteA700 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 23.fSize,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeWhiteA70023 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 23.fSize,
      );
  static get titleMediumLexendExaPink900 =>
      theme.textTheme.titleMedium!.lexendExa.copyWith(
        color: appTheme.pink900,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallLexendExaOnPrimaryContainer =>
      theme.textTheme.titleSmall!.lexendExa.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleSmallLexendExaPink900 =>
      theme.textTheme.titleSmall!.lexendExa.copyWith(
        color: appTheme.pink900,
      );
}

extension on TextStyle {
  // ignore: unused_element
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

  TextStyle get lexendDeca {
    return copyWith(
      fontFamily: 'Lexend Deca',
    );
  }
}

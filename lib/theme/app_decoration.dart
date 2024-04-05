import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';


class AppDecoration {
  // Fill decorations
  
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray5001,
      );
  static BoxDecoration get fillGray400 => BoxDecoration(
        color: appTheme.gray400,
      );
  static BoxDecoration get fillGray200 => BoxDecoration(
        color: appTheme.gray200,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
      );
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );

  // Outline decorations
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.pink900,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1.84,
            ),
          ),
        ],
      );
  static BoxDecoration get outlinePrimary1 => BoxDecoration(
        color:appTheme.gray5001,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1.84,
            ),
          ),
        ],
      );
  static BoxDecoration get outlinePrimary2 => BoxDecoration(
        color: appTheme.gray50,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1.84,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder18 => BorderRadius.circular(
        18.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get roundedBorder27 => BorderRadius.circular(
        27.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );

  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder21 => BorderRadius.circular(
        21.h,
      );
  static BorderRadius get roundedBorder31 => BorderRadius.circular(
        31.h,
      );
  static BorderRadius get roundedBorder6 => BorderRadius.circular(
        6.h,
      );
}
// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;

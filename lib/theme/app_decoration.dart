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
        color: theme.colorScheme.onError, // zainabs theme.colorScheme.onError.withOpacity(1),
      );
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );
  static BoxDecoration get fillGray2 => BoxDecoration(
        color: appTheme.gray50,
      );
  static BoxDecoration get fillPink => BoxDecoration(
        color: appTheme.pink900,
      );


  
  
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );

  static BoxDecoration get gradientGrayToTeal => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.96, 0.5),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.gray400,
            appTheme.teal300,
          ],
        ),
      );
  static BoxDecoration get gradientTealToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0.5),
          end: Alignment(0.83, 0.56),
          colors: [
            appTheme.teal300,
            appTheme.gray400,
          ],
        ),
      );
  
  static BoxDecoration get outlineBlack => BoxDecoration();

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


  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: appTheme.gray50,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1.85,
            ),
          ),
        ],
      );

  
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.gray50,
      );
  static BoxDecoration get outlineGray500 => BoxDecoration();

  
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

  static BorderRadius get circleBorder55 => BorderRadius.circular(
        55.h,
      );

  // Custom borders
  static BorderRadius get customBorderTL22 => BorderRadius.horizontal(
        left: Radius.circular(22.h),
      );

  // Rounded borders
  
  static BorderRadius get roundedBorder48 => BorderRadius.circular(
        48.h,
      );

  // Merge
  static BorderRadius get customBorderBL22 => BorderRadius.vertical(
        bottom: Radius.circular(22.h),
      );


  static BorderRadius get circleBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get circleBorder9 => BorderRadius.circular(
        9.h,
      );

  // Custom borders
  static BorderRadius get customBorderTL34 => BorderRadius.only(
        topLeft: Radius.circular(34.h),
        topRight: Radius.circular(34.h),
        bottomLeft: Radius.circular(34.h),
        bottomRight: Radius.circular(33.h),
      );

  static BorderRadius get circleBorder37 => BorderRadius.circular(
        37.h,
      );
  static BorderRadius get circleBorder50 => BorderRadius.circular(
        50.h,
      );

  static BorderRadius get circleBorder45 => BorderRadius.circular(
        45.h,
      );
  static BorderRadius get circleBorder69 => BorderRadius.circular(
        69.h,
      );

  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder17 => BorderRadius.circular(
        17.h,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
  
  static BorderRadius get roundedBorder18 => BorderRadius.circular(
        18.h,
      );


  static BorderRadius get roundedBorder23 => BorderRadius.circular(
        23.h,
      );
  static BorderRadius get roundedBorder41 => BorderRadius.circular(
        41.h,
      );

  static BorderRadius get roundedBorder71 => BorderRadius.circular(
        71.h,
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

import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Outline button style
  static ButtonStyle get outlinePrimaryTL20 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.pink900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        shadowColor: theme.colorScheme.primary,
        elevation: 2,
      );
  static ButtonStyle get outlinePrimaryTL33 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.pink900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              33.h,
            ),
            topRight: Radius.circular(
              33.h,
            ),
            bottomLeft: Radius.circular(
              33.h,
            ),
            bottomRight: Radius.circular(
              32.h,
            ),
          ),
        ),
        shadowColor: theme.colorScheme.primary,
        elevation: 2,
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}

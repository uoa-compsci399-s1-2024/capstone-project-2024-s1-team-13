import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AdminRemoveTraineesDialog extends StatelessWidget {
  const AdminRemoveTraineesDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 304.h,
          padding: EdgeInsets.symmetric(
            horizontal: 27.h,
            vertical: 30.v,
          ),
          decoration: AppDecoration.fillWhiteA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder23,
          ),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 11.v),
                Text(
                  "Remove John Doe and his details?",
                  style: CustomTextStyles.titleMediumBlack900,
                ),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 9.h,
                    right: 9.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                          context,
                          "YES",
                          CustomTextStyles.titleMediumWhiteA700,
                          AppDecoration.fillPink.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder23)),
                      SizedBox(width: 5.h),
                      _buildButton(
                          context,
                          "NO",
                          CustomTextStyles.titleMediumWhiteA700,
                          AppDecoration.fillPink.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder23)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, TextStyle textStyle,
      BoxDecoration decoration) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (text == "YES") {
            Navigator.pushNamed(context,
                AppRoutes.adminTraineeView); // Navigate to another screen
          } else {
            Navigator.of(context).pop(); // Close the dialog
          }
        },
        child: Container(
          decoration: AppDecoration.outlineBlack,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 33.h, vertical: 9.v),
            decoration: decoration,
            child: Center(
              // Center the text horizontally and vertically
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

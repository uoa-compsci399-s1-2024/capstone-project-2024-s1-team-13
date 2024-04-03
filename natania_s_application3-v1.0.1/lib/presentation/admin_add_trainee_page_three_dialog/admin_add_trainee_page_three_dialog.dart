import 'package:natania_s_application3/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AdminAddTraineePageThreeDialog extends StatelessWidget {
  const AdminAddTraineePageThreeDialog({Key? key})
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
                  "Save trainee details?",
                  style: CustomTextStyles.titleMediumBlack900,
                ),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 9.h,
                    right: 7.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.h),
                        decoration: AppDecoration.outlineBlack,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 33.h,
                            vertical: 9.v,
                          ),
                          decoration: AppDecoration.fillPink.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder23,
                          ),
                          child: Text(
                            "YES",
                            style: CustomTextStyles.titleMediumWhiteA700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          text: "NO",
                          margin: EdgeInsets.only(left: 5.h),
                        ),
                      ),
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
}

import 'package:natania_s_application3/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

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
            horizontal: 25.h,
            vertical: 23.v,
          ),
          decoration: AppDecoration.fillWhiteA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder23,
          ),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 3.v),
                SizedBox(
                  width: 250.h,
                  child: Text(
                    "Remove John Doe and his details?",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleMediumBlack900,
                  ),
                ),
                SizedBox(height: 21.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    right: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6.h),
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
                          margin: EdgeInsets.only(left: 6.h),
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

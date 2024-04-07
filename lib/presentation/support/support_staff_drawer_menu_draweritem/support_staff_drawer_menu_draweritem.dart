import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart'; // ignore_for_file: must_be_immutable

class SupportStaffDrawerMenuDraweritem extends StatelessWidget {
  const SupportStaffDrawerMenuDraweritem({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 250.h,
        padding: EdgeInsets.all(17.h),
        decoration: AppDecoration.fillWhiteA.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL22,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgClose,
              height: 13.adaptSize,
              width: 13.adaptSize,
              onTap: () {
                onTapImgClose(context);
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 52.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 29.h,
                  vertical: 13.v,
                ),
                decoration: AppDecoration.gradientGrayToTeal.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder55,
                ),
                child: Text(
                  "S",
                  style: CustomTextStyles.lexendExaWhiteA700,
                ),
              ),
            ),
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 15.h),
                child: Text(
                  "Support Staff",
                  style: CustomTextStyles.titleMedium19,
                ),
              ),
            ),
            SizedBox(height: 78.v),
            Padding(
              padding: EdgeInsets.only(left: 30.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgHome,
                    height: 25.v,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 14.h,
                      top: 3.v,
                    ),
                    child: Text(
                      "HOME",
                      style: MyTextStyles.titleMedium2,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 19.v),
            Padding(
              padding: EdgeInsets.only(left: 30.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgCheckmark,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    margin: EdgeInsets.only(bottom: 2.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.h,
                      top: 3.v,
                    ),
                    child: Text(
                      "EVALUATE",
                      style: MyTextStyles.titleMedium2,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 19.v),
            GestureDetector(
              onTap: () {
                onTapSideMenuProfileButton(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 30.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 28.adaptSize,
                      width: 28.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 13.h,
                        top: 6.v,
                      ),
                      child: Text(
                        "PROFILE",
                        style: MyTextStyles.titleMedium2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 19.v),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 30.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup17,
                      height: 26.adaptSize,
                      width: 26.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 14.h,
                        top: 4.v,
                      ),
                      child: Text(
                        "SETTINGS",
                        style: MyTextStyles.titleMedium2,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapImgClose(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the profileContainerScreen when the action is triggered.
  onTapSideMenuProfileButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profileContainerScreen);
  }
}

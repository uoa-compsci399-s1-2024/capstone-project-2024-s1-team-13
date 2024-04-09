import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          // Wrap the Stack with SingleChildScrollView
          child: SizedBox(
            height: 433.v,
            width: 303.h,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.v),
                    child: Text(
                      "Assess",
                      style: CustomTextStyles.titleMedium17_1,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(left: 293.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                      vertical: 137.v,
                    ),
                    decoration: AppDecoration.fillGray400,
                    child: VerticalDivider(
                      width: 2.h,
                      thickness: 2.v,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 293.h,
                      bottom: 5.v,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                      vertical: 118.v,
                    ),
                    decoration: AppDecoration.fillGray400,
                    child: VerticalDivider(
                      width: 2.h,
                      thickness: 2.v,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 38.h,
                      top: 69.v,
                      right: 42.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 67.h,
                            right: 64.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.h,
                            vertical: 9.v,
                          ),
                          decoration: AppDecoration.gradientGrayToTeal.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder45,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 2.v),
                              Text(
                                "A",
                                style: theme.textTheme.displayLarge,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8.v),
                        Text(
                          "Admin",
                          style: CustomTextStyles.titleMediumPink900,
                        ),
                        SizedBox(height: 40.v),
                        CustomElevatedButton(
                          text: "Change Login",
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.adminNewLogin);
                          },
                        ),
                        SizedBox(height: 17.v),
                        CustomElevatedButton(
                          text: "Logout",
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 50.v,
      leadingWidth: 29.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 15.h,
          top: 14.v,
          bottom: 17.v,
        ),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Settings",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMegaphone,
          margin: EdgeInsets.fromLTRB(17.h, 16.v, 17.h, 21.v),
        )
      ],
      styleType: Style.bgShadow,
      //styleType: Style.bgShadow_1,
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}

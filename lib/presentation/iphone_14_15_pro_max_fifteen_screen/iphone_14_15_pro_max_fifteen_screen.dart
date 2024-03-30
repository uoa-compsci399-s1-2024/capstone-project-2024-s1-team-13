import 'package:tetuhi/widgets/app_bar/custom_app_bar.dart';
import 'package:tetuhi/widgets/app_bar/appbar_leading_image.dart';
import 'package:tetuhi/widgets/app_bar/appbar_title_image.dart';
import 'package:tetuhi/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:tetuhi/core/app_export.dart';

class Iphone1415ProMaxFifteenScreen extends StatelessWidget {
  const Iphone1415ProMaxFifteenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildSeventySeven(context),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 17.h,
                  vertical: 20.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.h),
                      child: Text(
                        "John’s Summary",
                        style: CustomTextStyles.headlineLargePrimaryMedium,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.only(left: 13.h),
                      child: Text(
                        "Progress",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 2.v),
                    _buildSixty(context),
                    SizedBox(height: 19.v),
                    Padding(
                      padding: EdgeInsets.only(left: 11.h),
                      child: Text(
                        "Notes",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 4.v),
                    _buildFiftySeven(context),
                    SizedBox(height: 32.v),
                    _buildSeventyNine(context),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSeventySeven(BuildContext context) {
    return SizedBox(
      height: 61.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 100.h),
              child: Text(
                "dwqd",
                style: CustomTextStyles.headlineSmallInterWhiteA700,
              ),
            ),
          ),
          CustomAppBar(
            height: 52.v,
            leadingWidth: 47.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgIconBell,
              margin: EdgeInsets.only(
                left: 23.h,
                top: 12.v,
                bottom: 14.v,
              ),
            ),
            centerTitle: true,
            title: AppbarTitleImage(
              imagePath: ImageConstant.imgSettings,
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgGroup32,
                margin: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 10.v,
                ),
              ),
            ],
            styleType: Style.bgFill,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSixty(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 128.v,
        width: 365.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle144,
              height: 128.v,
              radius: BorderRadius.circular(
                25.h,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(29.h, 11.v, 13.h, 17.v),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 21.v,
                        bottom: 18.v,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "DISHES",
                            style: theme.textTheme.headlineLarge,
                          ),
                          Text(
                            "STEP 7 OUT 15",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 99.v,
                      width: 102.h,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 93.adaptSize,
                              width: 93.adaptSize,
                              decoration: BoxDecoration(
                                color: appTheme.whiteA700.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(
                                  46.h,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 18.h,
                                bottom: 29.v,
                              ),
                              child: Text(
                                "45%",
                                style: CustomTextStyles.titleLargeWhiteA700,
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgContrast,
                            width: 65.h,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFiftySeven(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 373.h,
        margin: EdgeInsets.only(
          left: 9.h,
          right: 13.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 22.h,
          vertical: 25.v,
        ),
        decoration: AppDecoration.outlinePrimary2.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "General",
              style: CustomTextStyles.titleMediumLexendExaPink900,
            ),
            SizedBox(height: 3.v),
            Container(
              width: 315.h,
              margin: EdgeInsets.only(
                left: 2.h,
                right: 10.h,
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.titleSmallLexendExaPink900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSeventyNine(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.h),
      padding: EdgeInsets.symmetric(
        horizontal: 53.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.outlinePrimary3.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder31,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              top: 5.v,
              bottom: 2.v,
            ),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgHome,
                  height: 29.v,
                ),
                SizedBox(height: 1.v),
                Text(
                  "HOME",
                  style: CustomTextStyles.labelMediumPink900,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgCheckmark,
                  height: 31.adaptSize,
                  width: 31.adaptSize,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 13.h),
                ),
                SizedBox(height: 3.v),
                Text(
                  "EVALUATE",
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgContrastOnprimarycontainer,
                  height: 33.adaptSize,
                  width: 33.adaptSize,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 8.h),
                ),
                SizedBox(height: 1.v),
                Text(
                  "PROFILE",
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

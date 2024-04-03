import 'package:natania_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:natania_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/app_export.dart';

class MacaroonsAuditoryScreen extends StatelessWidget {
  const MacaroonsAuditoryScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 551.v,
          width: 385.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: AppDecoration.fillOnError,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAppBar(context),
                      SizedBox(height: 21.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 35.h,
                            right: 7.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 2.h),
                                      child: CustomIconButton(
                                        height: 43.adaptSize,
                                        width: 43.adaptSize,
                                        padding: EdgeInsets.all(10.h),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.imgSound,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.v),
                                    _buildComponentTwentyNine(context),
                                    SizedBox(height: 19.v),
                                    _buildComponentThirty(context),
                                    SizedBox(height: 24.v),
                                    _buildComponentThirtyOne(context),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 18.h,
                                  top: 11.v,
                                  bottom: 70.v,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.h,
                                  vertical: 143.v,
                                ),
                                decoration:
                                    AppDecoration.fillErrorContainer.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder5,
                                ),
                                child: SizedBox(
                                  height: 95.v,
                                  child: VerticalDivider(
                                    width: 3.h,
                                    thickness: 3.v,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.v),
                    ],
                  ),
                ),
              ),
              _buildComponentThirtyTwo(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 34.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowRight,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 14.v,
          bottom: 14.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Macarons",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup19,
          margin: EdgeInsets.fromLTRB(18.h, 9.v, 18.h, 10.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildComponentTwentyNine(BuildContext context) {
    return Container(
      width: 309.h,
      margin: EdgeInsets.only(right: 2.h),
      padding: EdgeInsets.all(8.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 3.v,
                ),
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder16,
                ),
                child: Text(
                  "1",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 13.h,
                  top: 8.v,
                  bottom: 5.v,
                ),
                child: Text(
                  "STEP ONE",
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
          SizedBox(height: 7.v),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 262.h,
              margin: EdgeInsets.only(
                left: 12.h,
                right: 17.h,
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium,
              ),
            ),
          ),
          SizedBox(height: 5.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentThirty(BuildContext context) {
    return Container(
      width: 309.h,
      margin: EdgeInsets.only(left: 2.h),
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 3.v,
                ),
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder16,
                ),
                child: Text(
                  "2",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  top: 8.v,
                  bottom: 5.v,
                ),
                child: Text(
                  "STEP TWO",
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
          SizedBox(height: 9.v),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 262.h,
              margin: EdgeInsets.only(
                left: 15.h,
                right: 17.h,
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium,
              ),
            ),
          ),
          SizedBox(height: 7.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentThirtyOne(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: appTheme.gray50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: Container(
        height: 122.v,
        width: 309.h,
        padding: EdgeInsets.symmetric(
          horizontal: 8.h,
          vertical: 9.v,
        ),
        decoration: AppDecoration.outlinePrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder23,
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgClose,
              height: 32.adaptSize,
              width: 32.adaptSize,
              alignment: Alignment.topLeft,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.h,
                  top: 3.v,
                ),
                child: Row(
                  children: [
                    Text(
                      "3",
                      style: theme.textTheme.titleMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 23.h,
                        top: 5.v,
                      ),
                      child: Text(
                        "STEP THREE",
                        style: theme.textTheme.labelLarge,
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
  Widget _buildComponentThirtyTwo(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25.h,
          vertical: 14.v,
        ),
        decoration: AppDecoration.fillOnError,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MACARONS",
              style: theme.textTheme.labelLarge,
            ),
            SizedBox(height: 5.v),
            Row(
              children: [
                Container(
                  decoration: AppDecoration.fillBlueGray.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder9,
                  ),
                  child: Container(
                    height: 18.v,
                    width: 146.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(
                        9.h,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "45%",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.v),
          ],
        ),
      ),
    );
  }
}

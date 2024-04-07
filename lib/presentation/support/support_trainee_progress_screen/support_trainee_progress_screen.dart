import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable

class SupportTraineeProgressScreen extends StatelessWidget {
  SupportTraineeProgressScreen({Key? key})
      : super(
          key: key,
        );

  //GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: 370.h,
          padding: EdgeInsets.symmetric(
            horizontal: 22.h,
            vertical: 14.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Progress",
                style: MyTextStyles.headlineMedium2,
              ),
              SizedBox(height: 12.v),
              Container(
                decoration: AppDecoration.fillGray2.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder22,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.v),
                    Container(
                      width: 170.h,
                      margin: EdgeInsets.only(left: 19.h),
                      child: Text(
                        "Closing Kitchen Evaluation",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.titleMedium2,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    _buildFifteen(context),
                    _buildTwelve(context),
                    _buildFourteen(context),
                    _buildThirteen(context),
                  ],
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 33.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronBackButton,
        margin: EdgeInsets.only(
          left: 15.h,
          top: 14.v,
          bottom: 14.v,
        ),
        onTap: () {
          onTapBackProfile(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Progress",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgSettingsButton,
          margin: EdgeInsets.fromLTRB(18.h, 11.v, 18.h, 13.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildFifteen(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillGray2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "45% Completed", // Pending backend functionality
            style: MyTextStyles.labelMedium2,
          ),
          SizedBox(height: 4.v),
          Container(
            height: 17.v,
            width: 291.h,
            decoration: BoxDecoration(
              color: appTheme.blueGray100,
              borderRadius: BorderRadius.circular(
                8.h,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                8.h,
              ),
              child: LinearProgressIndicator(
                value: 0.60, // Pending backend functionality
                backgroundColor: appTheme.blueGray100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  appTheme.pink900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTwelve(BuildContext context) {
    return Container(
      width: 326.h,
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 8.v,
      ),
      decoration: AppDecoration.fillGray2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Times Evaluated: ",
                  style: CustomTextStyles.labelMediumff000000,
                ),
                TextSpan(
                  text: "3", // Pending backend functionality
                  style: CustomTextStyles.labelMediumff89375f,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFourteen(BuildContext context) {
    return Container(
      width: 326.h,
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillWhiteA,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Recent Feedback: ",
              style: CustomTextStyles.labelMediumff000000,
            ),
            TextSpan(
              text: "Very Good",
              style: CustomTextStyles.labelMediumff89375f,
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  /// Section Widget
  Widget _buildThirteen(BuildContext context) {
    return Container(
      width: 326.h,
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillGray2.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL22,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notes:",
            style: MyTextStyles.labelMedium2,
          ),
          SizedBox(height: 10.v),
          Container(
            width: 282.h,
            margin: EdgeInsets.only(
              left: 6.h,
              right: 7.h,
            ),
            child: Text(
              "Lorem ipsum dolor sit amet, conse tetur adipiscing elit.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: MyTextStyles.bodySmall2,
            ),
          ),
          SizedBox(height: 16.v),
        ],
      ),
    );
  }

  // Navigation
  onTapBackProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeProfilePage);
  }
}

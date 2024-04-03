import 'package:natania_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AdminTraineeProfilePage extends StatelessWidget {
  const AdminTraineeProfilePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: 385.h,
          padding: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 4.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.v),
              _buildTrainingProgrammes(context),
              SizedBox(height: 20.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(
                  "Progress",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 2.v),
              _buildComponentThirtySix(context),
              SizedBox(height: 3.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "Notes",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 3.v),
              _buildComponentThirtySeven(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 34.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowRight,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 14.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup20,
          margin: EdgeInsets.fromLTRB(19.h, 11.v, 19.h, 14.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildTrainingProgrammes(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.h),
      decoration: AppDecoration.outlineBlack,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse116101x101,
            height: 101.adaptSize,
            width: 101.adaptSize,
            radius: BorderRadius.circular(
              50.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              top: 14.v,
              bottom: 52.v,
            ),
            child: Text(
              "John Doe",
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentThirtySix(BuildContext context) {
    return Container(
      width: 326.h,
      margin: EdgeInsets.only(
        left: 1.h,
        right: 23.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 125.h,
        vertical: 22.v,
      ),
      decoration: AppDecoration.gradientTealToGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgPerformance01,
        width: 62.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentThirtySeven(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 2.h,
        right: 22.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 121.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.gradientTealToGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgNotes,
        height: 78.adaptSize,
        width: 78.adaptSize,
      ),
    );
  }
}

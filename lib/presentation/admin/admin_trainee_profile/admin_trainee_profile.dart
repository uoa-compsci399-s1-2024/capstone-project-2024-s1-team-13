import 'package:istefat_s_application1/presentation/admin/adminSettings/admin_settings_screen.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AdminTraineeProfile extends StatelessWidget {
  const AdminTraineeProfile({Key? key})
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
      leadingWidth: 40.h,
      leading: GestureDetector(
        onTap: () {
          // Navigate to a specific screen when the back icon is tapped
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded, // Use the back icon
          color: Colors.white, // Set the icon color
          size: 40, // Set the icon size
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile",
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              right: 15.0), // Adjust the padding to move the icon to the left
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.adminSettingsScreen);
            },
            child: Icon(
              Icons.settings,
              color: Colors.white, // Set the icon color
              size: 40, // Set the icon size
            ),
          ),
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
              top: 28.v,
              bottom: 52.v,
            ),
            child: Text("John Doe",
                style: TextStyle(fontSize: 50, color: Colors.black87)),
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
      child: Container(
        height: 65.v,
        width: 60.h,
        //decoration: BoxDecoration(
        //  image: DecorationImage(
        //   image: AssetImage(ImageConstant.imgPerformance01),
        //   fit: BoxFit.cover,
        //  ),
        // ),
        child: Icon(Icons.bar_chart_sharp,
            size: 70, color: Colors.white), // Adjust icon size here
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentThirtySeven(BuildContext context) {
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
      child: Container(
        height: 65.v,
        width: 60.h,
        //decoration: BoxDecoration(
        //  image: DecorationImage(
        //   image: AssetImage(ImageConstant.imgPerformance01),
        //   fit: BoxFit.cover,
        //  ),
        // ),
        child: Icon(Icons.edit,
            size: 70, color: Colors.white), // Adjust icon size here
      ),
    );
  }
}

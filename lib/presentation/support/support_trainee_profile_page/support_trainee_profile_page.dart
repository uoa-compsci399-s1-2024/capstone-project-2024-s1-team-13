import 'package:istefat_s_application1/presentation/support/support_trainee_notes_page/support_trainee_notes_page.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportTraineeProfilePage extends StatelessWidget {
  SupportTraineeProfilePage({Key? key})
      : super(
          key: key,
        );
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 18.h,
            vertical: 9.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.v),
              _buildTrainingProgrammes(context),
              SizedBox(height: 12.v),
              Padding(
                padding: EdgeInsets.only(left: 7.h),
                child: Text(
                  "Progress",
                  style: MyTextStyles.titleMedium2,
                ),
              ),
              _buildProgressButton(context),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Text(
                  "Notes",
                  style: MyTextStyles.titleMedium2,
                ),
              ),
              SizedBox(height: 2.v),
              _buildNotesButton(context),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 7.v),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
    leadingWidth: 36.h,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context); // Navigate back to the previous screen
      },
      child: Padding(
        padding: EdgeInsets.only(left: 18.h, top: 12.v, bottom: 12.v),
        child: Icon(
          Icons.arrow_back,
          size: 36, // Adjust the size as needed
          color: Colors.white, // Adjust the color as needed
        ),
      ),
    ),
    centerTitle: true,
    title: AppbarTitle(
      text: "Profile",
    ),
    actions: [
      AppbarTrailingImage(
        imagePath: ImageConstant.imgSettingsButton,
        margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.v),
      ),
    ],
    styleType: Style.bgShadow,
  );
}


  /// Section Widget
  Widget _buildTrainingProgrammes(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 6.h,
        right: 1.h,
      ),
      decoration: AppDecoration.outlineBlack,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse116,
            height: 97.adaptSize,
            width: 97.adaptSize,
            radius: BorderRadius.circular(
              48.h,
            ),
            margin: EdgeInsets.only(bottom: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              top: 12.v,
              bottom: 53.v,
            ),
            child: Text(
              "John Doe",
              style: MyTextStyles.headlineMedium2,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProgressButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapTraineeProgress(context);
        },
        child: Container(
          width: 331.h,
          margin: EdgeInsets.only(right: 1.h),
          padding: EdgeInsets.symmetric(
            horizontal: 127.h,
            vertical: 21.v,
          ),
          decoration: AppDecoration.gradientTealToGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder22,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgPerformance01,
            width: 63.h,
          ),
        ));
  }

  /// Section Widget
  Widget _buildNotesButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapTraineeNotes(context);
        },
        child: Container(
          width: 331.h,
          margin: EdgeInsets.only(right: 1.h),
          padding: EdgeInsets.symmetric(
            horizontal: 127.h,
            vertical: 21.v,
          ),
          decoration: AppDecoration.gradientTealToGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder22,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgNotes,
            height: 75.v,
          ),
        ));
  }

  /// Section Widget -- Bottom Bar
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      }, selectedIndex: 2,
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return "/"; // To be added
      case BottomBarEnum.Evaluate:
        return "/"; // To be added
      case BottomBarEnum.Profile:
        return AppRoutes.supportTraineeNotesPage; // To be changed
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.supportTraineeNotesPage:
        return SupportTraineeNotesPage();
      default:
        return DefaultWidget();
    }
  }
}

// Navigation

// Navigates to Progress Screen once action is triggered

onTapTraineeProgress(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.supportTraineeProgressScreen);
}

// Navigates to Notes Screen once action is triggered

onTapTraineeNotes(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
}

onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
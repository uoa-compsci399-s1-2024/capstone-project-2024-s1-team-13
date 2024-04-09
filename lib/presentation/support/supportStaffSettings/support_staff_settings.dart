import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

import '../../../widgets/app_bar/appbar_title.dart';

class SupportStaffSettings extends StatelessWidget {
  const SupportStaffSettings({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 478.v,
          width: 334.h,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: AppDecoration.fillWhiteA,
                  child: _buildAppBar(context),
                ),
              ),
              
              
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.h,
                    top: 8.v,
                    right: 16.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTen(context),
                      SizedBox(height: 40.v),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 98.h,
                            right: 102.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 26.h,
                            vertical: 12.v,
                          ),
                          decoration: AppDecoration.gradientGrayToTeal.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder50,
                          ),
                          child: Text(
                            "S",
                            style: theme.textTheme.displayLarge,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.v),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Support Staff",
                          style: CustomTextStyles.titleMediumOnPrimary,
                        ),
                      ),
                      SizedBox(height: 92.v),
                      CustomElevatedButton(
                        text: "Switch Trainee",
                        margin: EdgeInsets.only(
                          left: 22.h,
                          right: 32.h,
                        ),
                        onPressed: () {
                          onTapSwitchTrainee(context);
                        },
                      ),
                      SizedBox(height: 18.v),
                      CustomElevatedButton(
                        text: "Logout",
                        margin: EdgeInsets.only(
                          left: 22.h,
                          right: 32.h,
                        ),
                        onPressed: () {
                          //add home screen link when logout pressed
                          Navigator.pushNamed(context, AppRoutes.welcomeScreen);
                          
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
    height: 46.v,
    leadingWidth: 35.h,
    
    centerTitle: true,
    title: AppbarTitle(
      text: "Settings",
    ),
    
    styleType: Style.bgShadow,
    //styleType: Style.bgShadow_1,
  );
}



  /// Section Widget
  Widget _buildTen(BuildContext context) {
 return Row(
    children: [
      GestureDetector(
        onTap: () {
          onTapImgArrowLeft(context);
        },
        
          child: Icon(
            Icons.chevron_left_rounded,
            size: 70,
            color: Colors.white,
          ),
        
      ),
      Spacer(flex: 57),
      
      Spacer(flex: 42),
      GestureDetector(
        onTap: () {
          onTapSwitchTrainee(context);
        },
        child: CustomImageView(
          imagePath: ImageConstant.imgGroup19,
          height: 28.adaptSize,
          width: 28.adaptSize,
        ),
      ),
    ],
  );
}
  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the trainee selection when the action is triggered.
  onTapSwitchTrainee(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportSelectTrainee);
  }
}

import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

import '../trainees/task_recipe_screen/task_recipe_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 390.h,
          child: Column(
            children: [
              SizedBox(height: 5.v),
              Container(
                margin: EdgeInsets.only(right: 5.h),
                padding: EdgeInsets.symmetric(vertical: 16.v),
                decoration: AppDecoration.fillWhiteA,
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgScreenshot20240316,
                      height: 42.v,
                    ),
                    SizedBox(height: 14.v),
                    Text(
                      "Welcome to Te Tuhi Café",
                      style: CustomTextStyles.titleLargePrimary,
                    ),
                    SizedBox(height: 21.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgScreenshot20240325,
                      height: 247.v,
                    ),
                    SizedBox(height: 21.v),
                    CustomElevatedButton(
                      text: "Training Modules",
                      margin: EdgeInsets.only(
                        left: 56.h,
                        right: 46.h,
                      ),
                      leftIcon: Container(
                        margin: EdgeInsets.only(right: 22.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgBook1,
                          height: 46.adaptSize,
                          width: 46.adaptSize,
                        ),
                      ),
                      buttonStyle: CustomButtonStyles.outlinePrimary,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.taskRecipeScreen);
                        //Navigator.pushNamed(context, AppRoutes.notificationsScreen);
                      },
                    ),
                    SizedBox(height: 18.v),
                    CustomElevatedButton(
                      text: "Login",
                      margin: EdgeInsets.only(
                        left: 56.h,
                        right: 46.h,
                      ),
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.adminSupportLoginScreen);
                      },
                    ),
                    SizedBox(height: 10.v),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:tetuhi/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tetuhi/core/app_export.dart';

class Iphone1415ProMaxTwoScreen extends StatelessWidget {
  const Iphone1415ProMaxTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 65.v),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgScreenshot20240316,
                height: 47.v,
              ),
              SizedBox(height: 16.v),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Text(
                    "Welcome to Te Tuhi Café",
                    style: CustomTextStyles.headlineSmall24,
                  ),
                ),
              ),
              SizedBox(height: 24.v),
              CustomImageView(
                imagePath: ImageConstant.imgScreenshot20240325,
                height: 275.v,
              ),
              SizedBox(height: 24.v),
              Container(
                margin: EdgeInsets.only(
                  left: 62.h,
                  right: 53.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 7.h,
                  vertical: 5.v,
                ),
                decoration: AppDecoration.outlinePrimary.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder31,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgBook1,
                      height: 51.adaptSize,
                      width: 51.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.h,
                        top: 15.v,
                        bottom: 10.v,
                      ),
                      child: Text(
                        "Training Modules",
                        style: CustomTextStyles.titleLargeLexendDecaPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21.v),
              CustomElevatedButton(
                text: "Login ",
                margin: EdgeInsets.only(
                  left: 62.h,
                  right: 53.h,
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}

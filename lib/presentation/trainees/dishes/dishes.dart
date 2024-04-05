import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:dotted_border/dotted_border.dart';

class Dishes extends StatelessWidget {
  const Dishes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          height: 548.v,
          width: 382.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.h,
                    vertical: 14.v,
                  ),
                  decoration: AppDecoration.fillWhiteA,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Training",
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: 35.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 9.h,
                            right: 60.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 36.adaptSize,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.h,
                                  vertical: 5.v,
                                ),
                                decoration: AppDecoration.fillGray400.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder18,
                                ),
                                child: Text(
                                  "9",
                                  style: CustomTextStyles.titleLarge20,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 210.h,
                                  margin: EdgeInsets.only(
                                    left: 15.h,
                                    top: 3.v,
                                    bottom: 4.v,
                                  ),
                                  child: Text(
                                    "Use the designated sponge for dishes, scrub the dish until clean",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.labelMediumPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 14.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgDishes1,
                        height: 267.v,
                        radius: BorderRadius.circular(
                          22.h,
                        ),
                      ),
                      SizedBox(height: 15.v),
                      _buildThirtyFive(context),
                      SizedBox(height: 35.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "[Main Task]",
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      SizedBox(height: 26.v),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 81.v,
                  width: 382.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.h,
                    ),
                    
                  ),
                ),
              ),
              
            ],
          ),
        ),
        bottomNavigationBar: _buildProgressBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 34.h,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.taskTrainMethodPage);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Dishes",
      ),
      
      styleType: Style.bgShadow,
    );
  }

  Widget _buildThirtyFive(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 9.h,
        right: 13.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedButton(
            width: 110.h,
            text: "BACK",
            buttonStyle: CustomButtonStyles.outlinePrimaryTL21,
            buttonTextStyle: CustomTextStyles.titleLargePink900,
          ),
          CustomElevatedButton(
            width: 110.h,
            text: "NEXT",
            buttonTextStyle: CustomTextStyles.titleLarge20,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 10.v), // Add some space above the progress bar
    child: Container(
      height: 5.v,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.h),
          topRight: Radius.circular(10.h),
        ),
        child: LinearProgressIndicator(
          value: 0.58,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            appTheme.pink900,
          ),
        ),
      ),
    ),
  );
}

  

  
}

import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportTraineeSummary extends StatelessWidget {
  const SupportTraineeSummary({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 353.h,
          padding: EdgeInsets.symmetric(horizontal: 21.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 60.h),
              ),
              SizedBox(height: 16.v),
              Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Text(
                  "John’s Summary",
                  style: CustomTextStyles.headlineSmallPrimaryContainer,
                ),
              ),
              SizedBox(height: 11.v),
              Padding(
                padding: EdgeInsets.only(left: 3.h),
                child: Text(
                  "Progress",
                  style: CustomTextStyles.titleMediumOnPrimary16,
                ),
              ),
              SizedBox(height: 2.v),
              _buildComponentOne(context),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "Notes",
                  style: CustomTextStyles.titleMediumOnPrimary16,
                ),
              ),
              SizedBox(height: 3.v),
              _buildComponentTwo(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
Widget _buildComponentOne(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/trainee_evaluate_1');
    },
    child: Container(
      height: 120.v,
      width: 350.h,
      margin: EdgeInsets.only(left: 2.h),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle144,
            height: 150.v,
            width: 450.v,
            radius: BorderRadius.circular(
              21.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.h, 9.v, 11.h, 14.v),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 17.v,
                      bottom: 14.v,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "DISHES",
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 1.v), // Adjust the vertical spacing
                        Text(
                          "STEP 7 OUT 15",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          )
                          
                        ),
                        SizedBox(height: 1.v), // Adjust the vertical spacing
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 83.v,
                    width: 83.h,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 76.adaptSize,
                            width: 76.adaptSize,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onError,
                              borderRadius: BorderRadius.circular(
                                38.h,
                              ),
                            ),
                            child: CircularProgressIndicator(
                              strokeWidth: 3.h,
                              value: 0.45, // set the progress value here
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>( 
                                appTheme.red300
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15.h,
                              bottom: 24.v,
                            ),
                            child: Text(
                              "45%",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        CustomImageView(
                          //imagePath: ImageConstant.imgContrast,
                          width: 62.h,
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
  Widget _buildComponentTwo(BuildContext context) {
    return Container(
      width: 305.h,
      margin: EdgeInsets.only(right: 4.h),
      padding: EdgeInsets.all(18.h),
      decoration: AppDecoration.outlinePrimary1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          Text(
            "General",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 3.v),
          Container(
            width: 257.h,
            margin: EdgeInsets.only(
              left: 2.h,
              right: 8.h,
            ),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.labelLargeOnPrimary,
            ),
          ),
        ],
      ),
    );
  }


  
}

import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class TaskAnalysisJudgecallScreen extends StatelessWidget {
  const TaskAnalysisJudgecallScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 46.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 267.h,
                  margin: EdgeInsets.only(right: 9.h),
                  child: Text(
                    "John has successfully completed the task",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleMediumBlack900,
                  ),
                ),
              ),
              SizedBox(height: 19.v),
              Container(
                width: 209.h,
                margin: EdgeInsets.only(
                  left: 38.h,
                  right: 30.h,
                ),
                child: Text(
                  "Do you think John has passed?",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: MyTextStyles.bodyMedium2,
                ),
              ),
              SizedBox(height: 16.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 29.h,
                  right: 27.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text("YES"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(245, 102),
                            foregroundColor: appTheme.whiteA700,
                            textStyle: TextStyle(
                              fontSize: 17.fSize,
                              fontFamily: 'Lexend Exa',
                              fontWeight: FontWeight.w500,
                            ),
                            backgroundColor: appTheme.pink900,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        onPressed: () {
                          onTapYES(context); // Temporary navigation
                        }),
                    CustomElevatedButton(
                      width: 106.h,
                      text: "NO",
                      margin: EdgeInsets.only(left: 8.h),
                      buttonStyle: CustomButtonStyles.outlineBlack,
                      buttonTextStyle: MyTextStyles.titleMedium2!,
                      onPressed: () {
                        onTapNO(context);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.v)
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
        imagePath: ImageConstant.imgBackChevronButton,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 12.v,
          bottom: 12.v,
        ),
        onTap: () {
          onTapBackChevronButton(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Evaluation",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgHamburgerMenu,
          margin: EdgeInsets.fromLTRB(14.h, 7.v, 14.h, 8.v),
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Navigates to the taskAnalysisMoodScreen when the action is triggered.
  onTapBackChevronButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisMoodScreen);
  }

  /// Navigates to the taskAnalysisNotesScreen when the action is triggered.
  onTapNO(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisNotesScreen);
  }

  // Navigates to TA Notes screen FOR NOW, but should navigate to the Evaluate Screen or previous TA
  onTapYES(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisNotesScreen);
  }
}

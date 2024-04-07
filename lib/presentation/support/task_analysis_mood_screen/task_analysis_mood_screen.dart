import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class TaskAnalysisMoodScreen extends StatelessWidget {
  const TaskAnalysisMoodScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAssess(context),
              SizedBox(height: 150.v),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: Column(
                  children: [
                    Container(
                      width: 223.h,
                      margin: EdgeInsets.only(
                        left: 31.h,
                        right: 34.h,
                      ),
                      child: Text(
                        "How did you feel about this task?",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleLargeBlack900,
                      ),
                    ),
                    SizedBox(height: 23.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomImageView(
                            imagePath: ImageConstant.imgVeryBadButton,
                            width: 53.h,
                            radius: BorderRadius.circular(
                              10.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            onTap: () {
                              onTapImgVeryBadButton(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomImageView(
                            imagePath: ImageConstant.imgBadButton,
                            width: 53.h,
                            radius: BorderRadius.circular(
                              10.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            onTap: () {
                              onTapImgBadButton(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomImageView(
                            imagePath: ImageConstant.imgNotSoGoodButton,
                            width: 53.h,
                            radius: BorderRadius.circular(
                              10.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            onTap: () {
                              onTapImgNotSoGoodButton(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomImageView(
                            imagePath: ImageConstant.imgGoodButton,
                            width: 53.h,
                            radius: BorderRadius.circular(
                              10.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            onTap: () {
                              onTapImgGoodButton(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomImageView(
                            imagePath: ImageConstant.imgVeryGoodButton,
                            width: 53.h,
                            radius: BorderRadius.circular(
                              10.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            onTap: () {
                              onTapImgVeryGoodButton(context);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 35.v),
                    Text(
                      "",
                    ),
                    SizedBox(height: 1.v)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAssess(BuildContext context) {
    return SizedBox(
      height: 46.v,
      width: double.maxFinite,
      child: CustomAppBar(
        leadingWidth: 37.h,
        leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgBackChevronButton,
          margin: EdgeInsets.only(
            left: 19.h,
            top: 11.v,
            bottom: 12.v,
          ),
        ),
        centerTitle: true,
        title: AppbarTitle(
          text: "Evaluation",
        ),
        actions: [
          AppbarTrailingImage(
            imagePath: ImageConstant.imgHamburgerMenu,
            margin: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 6.v),
          )
        ],
        styleType: Style.bgShadow,
      ),
    );
  }

  /// Navigates to the taskAnalysisJudgecallScreen when the action is triggered.
  onTapImgVeryBadButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisJudgecallScreen);
  }

  /// Navigates to the taskAnalysisJudgecallScreen when the action is triggered.
  onTapImgBadButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisJudgecallScreen);
  }

  /// Navigates to the taskAnalysisJudgecallScreen when the action is triggered.
  onTapImgNotSoGoodButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisJudgecallScreen);
  }

  /// Navigates to the taskAnalysisJudgecallScreen when the action is triggered.
  onTapImgGoodButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisJudgecallScreen);
  }

  /// Navigates to the taskAnalysisJudgecallScreen when the action is triggered.
  onTapImgVeryGoodButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisJudgecallScreen);
  }
}

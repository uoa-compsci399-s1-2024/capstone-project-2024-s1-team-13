import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class TaskAnalysisNotesScreen extends StatelessWidget {
  TaskAnalysisNotesScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController writenotehereController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 25.h,
            vertical: 45.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.v),
              Container(
                width: 204.h,
                margin: EdgeInsets.only(left: 44.h),
                child: Text(
                  "What could John improve on? ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleMediumBlack900,
                ),
              ),
              SizedBox(height: 14.v),
              Padding(
                padding: EdgeInsets.only(right: 3.h),
                child: CustomTextFormField(
                  controller: writenotehereController,
                  hintText: "Write note here",
                  textInputAction: TextInputAction.done,
                  alignment: Alignment.center,
                  maxLines: 9,
                ),
              ),
              SizedBox(height: 19.v),
              Center(
                  child: ElevatedButton(
                      child: Text("ADD NOTE"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 102),
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
                        onTapADDNOTES(context); // Temporary navigation
                      })),
              SizedBox(height: 14.v),
              Center(
                  child: TextButton(
                      onPressed: () {
                        onTapSKIP(context);
                      },
                      child: Text("Skip",
                          style: MyTextStyles.labelLarge2!.copyWith(
                            decoration: TextDecoration.underline,
                          ))))
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 38.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgBackChevronButton,
        margin: EdgeInsets.only(
          left: 20.h,
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
          margin: EdgeInsets.fromLTRB(18.h, 7.v, 18.h, 8.v),
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Navigates to the taskAnalysisJudgecallScreen when the action is triggered.
  onTapBackChevronButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskAnalysisJudgecallScreen);
  }

  // Navigates to Trainee Notes when the action is triggered (temporary).
  onTapADDNOTES(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
  }

  // Navigates to Trainee Notes when the action is triggered (temporary).
  onTapSKIP(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
  }
}

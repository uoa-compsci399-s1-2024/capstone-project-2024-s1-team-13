import 'package:natania_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:natania_s_application3/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

class AdminAddTraineeScreen extends StatelessWidget {
  AdminAddTraineeScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: 385.h,
          padding: EdgeInsets.symmetric(
            horizontal: 35.h,
            vertical: 20.v,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: CustomTextStyles.headlineMediumMedium,
                ),
              ),
              SizedBox(height: 60.v),
              Container(
                height: 138.adaptSize,
                width: 138.adaptSize,
                padding: EdgeInsets.all(46.h),
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder69,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgCamera,
                  height: 46.adaptSize,
                  width: 46.adaptSize,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 5.v),
              Text(
                "Add Photo",
                style: CustomTextStyles.labelLargePink900,
              ),
              SizedBox(height: 36.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: Text(
                    "Name",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
              SizedBox(height: 3.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.h),
                child: CustomTextFormField(
                  controller: nameController,
                  hintText: "Jack ",
                ),
              ),
              SizedBox(height: 22.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: Text(
                    "Surname",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
              SizedBox(height: 3.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.h),
                child: CustomTextFormField(
                  controller: surnameController,
                  hintText: "Sparrow",
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(height: 5.v),
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
        imagePath: ImageConstant.imgArrowRight,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 14.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Add Trainee ",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTick,
          margin: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 10.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}

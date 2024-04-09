import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class AdminEditTraineeDetails extends StatelessWidget {
  AdminEditTraineeDetails({Key? key})
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
          width: 399.h,
          padding: EdgeInsets.symmetric(
            horizontal: 36.h,
            vertical: 21.v,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 59.v),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse116143x143,
                height: 143.adaptSize,
                width: 143.adaptSize,
                radius: BorderRadius.circular(
                  71.h,
                ),
              ),
              SizedBox(height: 13.v),
              Text(
                "Change Photo",
                style: CustomTextStyles.titleSmallOnPrimary,
              ),
              SizedBox(height: 33.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: Text(
                    "Name",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(height: 3.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.h),
                child: CustomTextFormField(
                  controller: nameController,
                  hintText: "John ",
                ),
              ),
              SizedBox(height: 22.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: Text(
                    "Surname",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(height: 4.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.h),
                child: CustomTextFormField(
                  controller: surnameController,
                  hintText: "Doe",
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
      leadingWidth: 35.h,
      leading: GestureDetector(
        onTap: () {
          // Navigate to the previous screen
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 50,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Edit Details ",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTick,
          margin: EdgeInsets.fromLTRB(20.h, 10.v, 20.h, 11.v),
        ),
      ],
      styleType: Style.bgShadow,
      //styleType: Style.bgShadow_2,
    );
  }
}

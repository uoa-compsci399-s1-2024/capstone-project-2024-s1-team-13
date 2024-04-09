import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_drop_down.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AdminNewLogin extends StatelessWidget {
  AdminNewLogin({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: 421.v,
            width: 294.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter, //align towards top center
                  child: Container(
                    decoration: AppDecoration.fillWhiteA,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFortyFour(context),
                        SizedBox(height: 10.v),
                        Padding(
                          padding: EdgeInsets.only(left: 27.h, top: 5.v),
                          child: Text(
                            "Set New Login",
                            style: CustomTextStyles.titleLarge21,
                          ),
                        ),
                        SizedBox(
                            height: 40.v), //SPACING BETWEEN TEXT AND FIELDS
                        Padding(
                          padding: EdgeInsets.only(left: 30.h, top: 5.v),
                          child: Text(
                            "Login Type",
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                        SizedBox(height: 2.v, width:1.h),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.h,
                            right: 29.h,
                          ),
                          child: CustomDropDown(
                            icon: Container(
                              margin: EdgeInsets.fromLTRB(30.h, 4.v, 7.h, 4.v),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgDowndroparrow,
                                height: 17.adaptSize,
                                width: 17.adaptSize,
                              ),
                            ),
                            hintText: "Admin",
                            alignment: Alignment.center,
                            items: dropdownItemList,
                          ),
                        ),
                        SizedBox(height: 20.v),
                        Padding(
                          padding: EdgeInsets.only(left: 30.h),
                          child: Text(
                            "Username",
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 27.h,
                            right: 29.h,
                          ),
                          child: CustomTextFormField(
                            controller: userNameController,
                            hintText: "TeTuhiAdmin",
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(height: 17.v),
                        Padding(
                          padding: EdgeInsets.only(left: 30.h),
                          child: Text(
                            "Password",
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                        SizedBox(height: 5.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 27.h,
                            right: 29.h,
                          ),
                          child: CustomTextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            alignment: Alignment.center,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: 5.v)
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 339.v,
                    width: 8.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                      vertical: 134.v,
                    ),
                    decoration: AppDecoration.fillGray400,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 70.v,
                            child: VerticalDivider(
                              width: 2.h,
                              thickness: 2.v,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 70.v,
                            child: VerticalDivider(
                              width: 2.h,
                              thickness: 2.v,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFortyFour(BuildContext context) {
    return SizedBox(
      height: 36.v,
      width: 294.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Assess",
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
    height: 36.v,
    leadingWidth: 29.h,
    leading: AppbarLeadingImage(
      imagePath: ImageConstant.imgArrowLeft,
      margin: EdgeInsets.only(
        left: 15.h,
        top: 9.v,
        bottom: 9.v,
      ),
      onTap: () {
        onTapArrowLeft(context);
      },
    ),
    centerTitle: true,
    title: AppbarSubtitleOne(
      text: "Login",
    ),
    actions: [
      AppbarTrailingImage(
        imagePath: ImageConstant.imgTick,
        margin: EdgeInsets.fromLTRB(15.h, 7.v, 15.h, 4.v),
      )
    ],
    styleType: Style.bgShadow,
    //styleType: Style.bgShadow_2,
  );
}

//back button navigation
void onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
}

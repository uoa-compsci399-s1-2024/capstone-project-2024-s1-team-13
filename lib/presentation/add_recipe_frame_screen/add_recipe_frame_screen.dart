import 'package:sen_s_application1/widgets/custom_text_form_field.dart';
import 'package:sen_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:sen_s_application1/widgets/custom_icon_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sen_s_application1/widgets/custom_elevated_button.dart';
import 'package:sen_s_application1/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:sen_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AddRecipeFrameScreen extends StatelessWidget {
  AddRecipeFrameScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController instructionTexController = TextEditingController();

  TextEditingController instructionTexController1 = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 372.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTwentyOne(context),
                    SizedBox(height: 15.v),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.h),
                      child: Column(
                        children: [
                          _buildStepOneFrame(context),
                          SizedBox(height: 15.v),
                          _buildStepTwoFrame(context)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildADDSTEP(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      width: 372.h,
      controller: nameController,
      hintText: "Enter recipe name",
      alignment: Alignment.center,
      suffix: Container(
        padding: EdgeInsets.fromLTRB(18.h, 20.v, 18.h, 21.v),
        margin: EdgeInsets.fromLTRB(30.h, 14.v, 24.h, 14.v),
        decoration: BoxDecoration(
          color: appTheme.gray50,
          borderRadius: BorderRadius.circular(
            8.h,
          ),
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgBookmark,
          height: 26.v,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 144.v,
      ),
      contentPadding: EdgeInsets.only(
        left: 30.h,
        top: 63.v,
        bottom: 63.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
      fillColor: theme.colorScheme.onError,
    );
  }

  /// Section Widget
  Widget _buildTwentyOne(BuildContext context) {
    return SizedBox(
      height: 151.v,
      width: 372.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildName(context),
          CustomAppBar(
            leadingWidth: 32.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeft,
              margin: EdgeInsets.only(
                left: 15.h,
                top: 14.v,
                bottom: 15.v,
              ),
              onTap: () {
                onTapArrowLeft(context);
              },
            ),
            centerTitle: true,
            title: AppbarTitle(
              text: "Add Recipe",
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgAddRecipeBtnComponent,
                margin: EdgeInsets.fromLTRB(26.h, 9.v, 26.h, 10.v),
                onTap: () {
                  onTapImage(context);
                },
              )
            ],
            styleType: Style.bgShadow,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInstructionTex(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: instructionTexController,
        hintText: "Enter instruction",
      ),
    );
  }

  /// Section Widget
  Widget _buildStepOneFrame(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 35.v,
            width: 327.h,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle163,
                  height: 35.v,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.h,
                      bottom: 4.v,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 21.adaptSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.fillGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                          ),
                          child: Text(
                            "1",
                            style: CustomTextStyles.labelLargeOnError,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            top: 2.v,
                            bottom: 2.v,
                          ),
                          child: Text(
                            "STEP ONE",
                            style: theme.textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInstructionTex(context),
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: DottedBorder(
                      color: appTheme.gray500,
                      padding: EdgeInsets.only(
                        left: 1.h,
                        top: 1.v,
                        right: 1.h,
                        bottom: 1.v,
                      ),
                      strokeWidth: 1.h,
                      radius: Radius.circular(8),
                      borderType: BorderType.RRect,
                      dashPattern: [4.375934600830078, 4.375934600830078],
                      child: CustomIconButton(
                        height: 67.adaptSize,
                        width: 67.adaptSize,
                        padding: EdgeInsets.all(16.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgImage,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInstructionTex1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.h),
      child: CustomTextFormField(
        width: 224.h,
        controller: instructionTexController1,
        hintText: "Enter instruction",
        textInputAction: TextInputAction.done,
        maxLines: 4,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.h,
          vertical: 12.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStepTwoFrame(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35.v,
            width: 327.h,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle163,
                  height: 35.v,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.h,
                      bottom: 4.v,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 21.adaptSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.fillGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                          ),
                          child: Text(
                            "2",
                            style: CustomTextStyles.labelLargeOnError,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            top: 2.v,
                            bottom: 2.v,
                          ),
                          child: Text(
                            "STEP TWO",
                            style: theme.textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          _buildInstructionTex1(context),
          SizedBox(height: 14.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildADDSTEP(BuildContext context) {
    return CustomElevatedButton(
      text: "+ ADD STEP",
      margin: EdgeInsets.only(
        left: 24.h,
        right: 20.h,
        bottom: 23.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return DottedBorder(
      color: appTheme.gray500,
      padding: EdgeInsets.only(
        left: 1.h,
        top: 1.v,
        right: 1.h,
        bottom: 1.v,
      ),
      strokeWidth: 1.h,
      radius: Radius.circular(8),
      borderType: BorderType.RRect,
      dashPattern: [4.375934600830078, 4.375934600830078],
      child: CustomFloatingButton(
        height: 67,
        width: 67,
        backgroundColor: appTheme.gray50,
        child: CustomImageView(
          imagePath: ImageConstant.imgImage,
          height: 33.5.v,
          width: 33.5.h,
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the editRecipesFrameScreen when the action is triggered.
  onTapImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editRecipesFrameScreen);
  }
}

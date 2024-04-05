import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:istefat_s_application1/widgets/custom_floating_button.dart';
import 'package:istefat_s_application1/widgets/custom_icon_button.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';

class AddRecipeFrameScreen extends StatelessWidget {
  AddRecipeFrameScreen({Key? key}) : super(key: key);

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
      ),
    );
  }

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

  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      width: 372.h,
      controller: nameController,
      hintText: "Macarons",
      alignment: Alignment.center,
      suffix: Container(
        padding: EdgeInsets.fromLTRB(18.h, 20.v, 18.h, 21.v),
        margin: EdgeInsets.fromLTRB(30.h, 70.v, 30.h, 0.v),
        decoration: BoxDecoration(
          color: appTheme.gray50,
          borderRadius: BorderRadius.circular(
            8.h,
          ),
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgBookmark,
          height: 40.v,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 144.v,
      ),
      contentPadding: EdgeInsets.only(
        left: 50.h,
        top: 50.v,
        bottom: 63.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
      fillColor: theme.primaryColor,
    );
  }

  Widget _buildStepOneFrame(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Stack(
        children: [
          Column(
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
                    Positioned(
                      left: 12.h,
                      bottom: 4.v,
                      child: Row(
                        children: [
                          Container(
                            width: 21.adaptSize,
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.h,
                              vertical: 2.v,
                            ),
                            decoration: AppDecoration.fillGray400.copyWith(
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
                              style: CustomTextStyles.labelMediumPrimary,
                            ),
                          )
                        ],
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
                      child: DottedBorder(
                        color: appTheme.gray500,
                        padding: EdgeInsets.all(8.h),
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 14.v)
            ],
          ),
          Positioned(
            top: 10.v,
            right: 10.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgUser,
              height: 20.adaptSize,
              width: 20.adaptSize,
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionTex(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.h),
      child: CustomTextFormField(
        width: 224.h,
        controller: instructionTexController,
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

  Widget _buildStepTwoFrame(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Stack(
        children: [
          Column(
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
                    Positioned(
                      left: 7.h,
                      bottom: 4.v,
                      child: Row(
                        children: [
                          Container(
                            width: 22.adaptSize,
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.h,
                              vertical: 2.v,
                            ),
                            decoration: AppDecoration.fillGray400.copyWith(
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
                              style: CustomTextStyles.labelMediumPrimary,
                            ),
                          )
                        ],
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
                      child: DottedBorder(
                        color: appTheme.gray500,
                        padding: EdgeInsets.all(8.h),
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.v)
            ],
          ),
          Positioned(
            top: 10.v,
            right: 10.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgUser,
              height: 20.adaptSize,
              width: 20.adaptSize,
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildADDSTEP(BuildContext context) {
    return CustomElevatedButton(
      text: "+ ADD STEP",
      margin: EdgeInsets.only(
        left: 24.h,
        right: 20.h,
        bottom: 23.v,
      ),
      buttonStyle: CustomButtonStyles.outlinePrimary,
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  onTapImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editRecipesFrameScreen);
  }
}

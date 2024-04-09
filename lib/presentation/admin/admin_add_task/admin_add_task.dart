import 'package:istefat_s_application1/presentation/admin/adminTask/admin_task_1.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:istefat_s_application1/widgets/custom_floating_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class AdminAddTask extends StatelessWidget {
  AdminAddTask({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController enterinstructionController = TextEditingController();

  TextEditingController enterinstructionController1 = TextEditingController();

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
                width: 399.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildForty(context),
                    SizedBox(height: 16.v),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                        children: [
                          _buildComponentFortyTwo(context),
                          SizedBox(height: 16.v),
                          _buildComponentFortyThree(context),
                        ],
                      ),
                    ),
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: 68.v,
          bottom: 20.v,
        ),
        child: CustomTextFormField(
          controller: nameController,
          hintText: "Enter task name",
        ),
      ),
    );
  }

  Widget _buildForty(BuildContext context) {
    return SizedBox(
      height: 165.v,
      width: 399.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgTick,
            height: 33.adaptSize,
            width: 33.adaptSize,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              top: 10.v,
              right: 20.h,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 7.v),
              padding: EdgeInsets.symmetric(
                horizontal: 23.h,
                vertical: 17.v,
              ),
              decoration: AppDecoration.outlinePrimary1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildName(context),
                  Container(
                    height: 74.v,
                    width: 73.h,
                    margin: EdgeInsets.only(
                      left: 9.h,
                      top: 46.v,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.h,
                      vertical: 22.v,
                    ),
                    decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder9,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgBookmark,
                      height: 28.v,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomAppBar(
            leadingWidth: 32.h,
            leading: IconButton(
                icon: Icon(Icons.chevron_left),
                iconSize: 50,
                color: Colors.white, // Replace with your desired icon
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous page
                }),
            centerTitle: true,
            title: AppbarTitle(
              text: "Add Task",
            ),
            //styleType: Style.bgShadow_2,
            styleType: Style.bgShadow,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEnterinstruction(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: enterinstructionController,
        hintText: "Enter instruction",
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 28.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.fillGrayTL15,
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentFortyTwo(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 38.v,
            width: 358.h,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle163,
                  height: 38.v,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 13.h,
                      bottom: 4.v,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 23.adaptSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.fillGray400.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder9,
                          ),
                          child: Text(
                            "1",
                            style: CustomTextStyles.titleSmallOnError,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            top: 2.v,
                            bottom: 3.v,
                          ),
                          child: Text(
                            "STEP ONE",
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEnterinstruction(context),
                Container(
                  height: 74.v,
                  width: 73.h,
                  margin: EdgeInsets.only(left: 9.h),
                  padding: EdgeInsets.all(17.h),
                  decoration: AppDecoration.outlineGray500.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder9,
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgImage,
                    height: 38.adaptSize,
                    width: 38.adaptSize,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.v),
        ],
      ),
    );
  }

  /// Section Widget
  /// Section Widget
  Widget _buildEnterinstruction1(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 13.h),
        child: CustomTextFormField(
          controller: enterinstructionController1,
          hintText: "Enter instruction",
          maxLines: 4, // Set maxLines to ensure it doesn't overflow
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 13.v,
          ),
          borderDecoration: TextFormFieldStyleHelper.fillGrayTL15,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentFortyThree(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder23,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 38.v,
            width: 358.h,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle163,
                  height: 38.v,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 13.h,
                      bottom: 4.v,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 23.adaptSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.fillGray400.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder9,
                          ),
                          child: Text(
                            "2",
                            style: CustomTextStyles.titleSmallOnError,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            top: 2.v,
                            bottom: 3.v,
                          ),
                          child: Text(
                            "STEP TWO",
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEnterinstruction1(context),
                Container(
                  height: 74.v,
                  width: 73.h,
                  margin: EdgeInsets.only(left: 9.h),
                  padding: EdgeInsets.all(17.h),
                  decoration: AppDecoration.outlineGray500.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder9,
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgImage,
                    height: 38.adaptSize,
                    width: 38.adaptSize,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildADDSTEP(BuildContext context) {
    return CustomElevatedButton(
      text: "+ ADD STEP",
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 30.v,
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
      radius: Radius.circular(9),
      borderType: BorderType.RRect,
      dashPattern: [
        4.789492607116699,
        4.789492607116699,
      ],
      child: CustomFloatingButton(
        height: 74,
        width: 73,
        backgroundColor: appTheme.gray50,
        child: CustomImageView(
          imagePath: ImageConstant.imgImage,
          height: 37.0.v,
          width: 36.5.h,
        ),
      ),
    );
  }
}

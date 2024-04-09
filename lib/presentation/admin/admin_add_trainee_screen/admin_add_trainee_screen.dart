import 'package:istefat_s_application1/presentation/admin/admin_add_trainee_dialog/admin_add_trainee_dialog.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class AdminAddTrainee extends StatelessWidget {
  AdminAddTrainee({Key? key})
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
                  style: CustomTextStyles.titleLarge21,
                ),
              ),
              SizedBox(height: 60.v),
              Container(
                height: 138.adaptSize,
                width: 138.adaptSize,
                padding: EdgeInsets.all(46.h),
                decoration: AppDecoration.fillGray400.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder69,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgCamera,
                  height: 80.adaptSize,
                  width: 80.adaptSize,
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
      height: 49.v,
      leadingWidth: 38.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronBackButton,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 13.v,
          bottom: 13.v,
        ),
        onTap: () {
          onTapBack(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Edit Notes",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTickButton,
          height: 50,
          width:
              50, //edited appbar_trailing_image -- added height + width options
          margin: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 9.v),

          onTap: () {
            onTapTickButton(context);
            ;
          },
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  void onTapTickButton(BuildContext context) {
    _showSaveTraineeDialog(context); // Show Save Trainee Details dialog
  }

  void onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminTraineeView);
  }

  void _showSaveTraineeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: AdminAddTraineeDialog(),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}

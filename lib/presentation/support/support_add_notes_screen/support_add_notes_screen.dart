import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportAddNotesScreen extends StatelessWidget {
  SupportAddNotesScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController writeNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: 371.h,
          padding: EdgeInsets.symmetric(
            horizontal: 26.h,
            vertical: 15.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Note",
                style: MyTextStyles.headlineMedium2,
              ),
              SizedBox(height: 7.v),
              Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: CustomTextFormField(
                  //controller: writeNoteController, // add controller?
                  hintText: "Title",
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 6.v,
                  ),
                ),
              ),
              SizedBox(height: 16.v),
              Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: CustomTextFormField(
                  controller: writeNoteController,
                  hintText: "Write note here",
                  textInputAction: TextInputAction.done,
                  maxLines: 18,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.v,
                  ),
                  //borderDecoration: TextFormFieldStyleHelper.fillGrayTL22,
                  fillColor: appTheme.gray200,
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
      leadingWidth: 35.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronBackButton,
        margin: EdgeInsets.only(
          left: 17.h,
          top: 15.v,
          bottom: 14.v,
        ),
        onTap: () {
          onTapBack(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Add Note",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTickButton,
          margin: EdgeInsets.fromLTRB(16.h, 9.v, 16.h, 11.v),
          onTap: () {
            onTapTickButton(context);
          },
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Navigates to the notes screen when the action is triggered -- pending backend functionality
  onTapTickButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
  }

  // Navigates back to the notes screen -- does note create new note.

  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
  }
}

import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'widgets/supporteditnotes_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/presentation/support/support_remove_note_popup_dialog/support_remove_note_popup_dialog.dart';

// ignore_for_file: must_be_immutable
class SupportEditNotesScreen extends StatelessWidget {
  SupportEditNotesScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: 370.h,
          padding: EdgeInsets.symmetric(
            horizontal: 21.h,
            vertical: 19.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 3.h),
                child: Text(
                  "Notes",
                  style: MyTextStyles.headlineMedium2,
                ),
              ),
              SizedBox(height: 3.v),
              _buildTwentyOne(context),
              SizedBox(height: 15.v),
              _buildSupportEditNotes(context)
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
          margin: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 9.v),
          onTap: () {
            onTapTickButton(context);
          },
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildTwentyOne(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchView(
            controller: searchController,
            hintText: "Search Notes",
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgFilterButton,
          height: 26.adaptSize,
          width: 26.adaptSize,
          margin: EdgeInsets.only(
            left: 3.h,
            top: 5.v,
          ),
        )
      ],
    );
  }

  
  Widget _buildSupportEditNotes(BuildContext context) {
  return Expanded(
    child: ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10.v,
        );
      },
      itemCount: 2,
      itemBuilder: (context, index) {
        return SupporteditnotesItemWidget(
          onTapBtnContrast: () {
            onTapBtnContrast(context);
          },
        );
      },
    ),
  );
}

  /// Navigates to the supportTraineeNotesContainerScreen when the action is triggered.
  onTapTickButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
  }

  // Navigates back to the notes screen -- does note create new note.

  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeNotesPage);
  }

  /// Displays a dialog with the [SupportRemoveNotePopupDialog] content.
  onTapBtnContrast(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: SupportRemoveNotePopupDialog(),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }
}

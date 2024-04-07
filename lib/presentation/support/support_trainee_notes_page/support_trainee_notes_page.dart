import 'package:flutter/widgets.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'widgets/supporttraineenotes_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportTraineeNotesPage extends StatelessWidget {
  SupportTraineeNotesPage({Key? key})
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
          padding: EdgeInsets.symmetric(horizontal: 21.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(left: 7.h),
                child: Text(
                  "Notes",
                  style: MyTextStyles.headlineMedium2,
                ),
              ),
              SizedBox(height: 8.v),
              _buildTwentyThree(context),
              SizedBox(height: 14.v),
              _buildSupportTraineeNotes(context)
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
          onTapBackProfile(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Notes",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgAddButton,
          margin: EdgeInsets.fromLTRB(18.h, 10.v, 11.h, 2.v),
          onTap: () {
            onTapAddButton(context);
          },
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgEditButton,
          margin: EdgeInsets.only(
            left: 3.h,
            top: 10.v,
            right: 29.h,
          ),
          onTap: () {
            onTapEditButton(context);
          },
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget - Search
  Widget _buildTwentyThree(BuildContext context) {
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
            top: 3.v,
            bottom: 2.v,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildSupportTraineeNotes(BuildContext context) {
    return ListView.separated(
      physics:
          AlwaysScrollableScrollPhysics(), // To let user scroll. -> was initially set to 'never'
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10.v,
        );
      },
      itemCount: 2, // To increment every time a note is added.
      itemBuilder: (context, index) {
        return SupporttraineenotesItemWidget();
      },
    );
  }

  /// Navigates to the supportAddNotesScreen when the action is triggered.
  onTapAddButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportAddNotesScreen);
  }

  /// Navigates to the supportEditNotesScreen when the action is triggered.
  onTapEditButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportEditNotesScreen);
  } // Triggers invalid SVG, may need to replace svg with Material Icon

  onTapBackProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.supportTraineeProfilePage);
  }
}

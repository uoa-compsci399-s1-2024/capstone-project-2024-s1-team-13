import 'package:natania_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:natania_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/ten_item_widget.dart';
import 'package:natania_s_application3/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

class AdminEditTraineesScreen extends StatelessWidget {
  AdminEditTraineesScreen({Key? key})
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
          height: 500.v,
          width: 385.h,
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildTen(context),
              _buildThirteen(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 35.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowRight,
        margin: EdgeInsets.only(
          left: 17.h,
          top: 13.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Edit Trainees",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTick,
          margin: EdgeInsets.fromLTRB(17.h, 10.v, 17.h, 9.v),
        ),
      ],
      styleType: Style.bgShadow_1,
    );
  }

  /// Section Widget
  Widget _buildTen(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 18.h,
          top: 21.v,
        ),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 1.v,
            );
          },
          itemCount: 4,
          itemBuilder: (context, index) {
            return TenItemWidget();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildThirteen(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 67.v),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 31.v,
              width: 292.h,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CustomSearchView(
                      width: 292.h,
                      controller: searchController,
                      alignment: Alignment.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 33.h),
                      child: Text(
                        "Search Trainees",
                        style: CustomTextStyles.labelLargeGray40001,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFilter,
              height: 27.adaptSize,
              width: 27.adaptSize,
              margin: EdgeInsets.only(
                left: 3.h,
                bottom: 2.v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

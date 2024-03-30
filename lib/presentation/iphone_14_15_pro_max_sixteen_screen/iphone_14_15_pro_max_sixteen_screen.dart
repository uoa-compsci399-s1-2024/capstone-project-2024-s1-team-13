import 'package:tetuhi/widgets/app_bar/custom_app_bar.dart';
import 'package:tetuhi/widgets/app_bar/appbar_leading_image.dart';
import 'package:tetuhi/widgets/app_bar/appbar_title.dart';
import 'package:tetuhi/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tetuhi/widgets/custom_search_view.dart';
import 'widgets/sixtythree_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tetuhi/core/app_export.dart';

// ignore: must_be_immutable
class Iphone1415ProMaxSixteenScreen extends StatelessWidget {
  Iphone1415ProMaxSixteenScreen({Key? key})
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
          height: 870.v,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 18.v,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.h),
                  child: Text(
                    "Trainees",
                    style: CustomTextStyles.headlineLargePrimary,
                  ),
                ),
              ),
              _buildSeventyFour(context),
              _buildSixtyThree(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 61.v,
      leadingWidth: 47.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgIconBell,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 14.v,
          bottom: 21.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Trainees",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup32,
          margin: EdgeInsets.fromLTRB(28.h, 13.v, 28.h, 11.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildSeventyFour(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 51.v),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomSearchView(
                controller: searchController,
                hintText: "Search Trainees",
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFilter,
              height: 30.adaptSize,
              width: 30.adaptSize,
              margin: EdgeInsets.only(
                left: 3.h,
                top: 2.v,
                bottom: 2.v,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSixtyThree(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 1.v,
            );
          },
          itemCount: 6,
          itemBuilder: (context, index) {
            return const SixtythreeItemWidget();
          },
        ),
      ),
    );
  }
}

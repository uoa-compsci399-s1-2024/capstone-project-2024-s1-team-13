import 'package:natania_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'widgets/twelve_item_widget.dart';
import 'package:natania_s_application2/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/app_export.dart';

class SupportWorkerViewScreen extends StatelessWidget {
  SupportWorkerViewScreen({Key? key})
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
          height: 501.v,
          width: 385.h,
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildTwelve(context),
              _buildFourteen(context),
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
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgIconBell,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 14.v,
          bottom: 11.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Trainees",
      ),
      styleType: Style.bgShadow_1,
    );
  }

  /// Section Widget
  Widget _buildTwelve(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          left: 18.h,
          top: 23.v,
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
            return TwelveItemWidget();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFourteen(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 69.v),
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

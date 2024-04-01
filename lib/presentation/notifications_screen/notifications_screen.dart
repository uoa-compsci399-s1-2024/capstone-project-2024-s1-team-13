import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/notifications_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: 383.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 22.v,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 18.h),
                  child: Text(
                    "Clear",
                    style: CustomTextStyles.labelMediumPink900,
                  ),
                ),
              ),
              SizedBox(height: 16.v),
              _buildNotifications(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 34.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgBackChevronIcon,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 14.v,
          bottom: 13.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Notifications",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup17,
          margin: EdgeInsets.symmetric(
            horizontal: 18.h,
            vertical: 11.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildNotifications(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 3.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 25.v,
            );
          },
          itemCount: 2,
          itemBuilder: (context, index) {
            return NotificationsItemWidget();
          },
        ),
      ),
    );
  }
}

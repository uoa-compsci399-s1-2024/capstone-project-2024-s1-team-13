import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_subtitle.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/admin_notification_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: 309.h,
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 20.v,
          ),
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  "Notifications",
                  style: CustomTextStyles.titleLargeOnPrimary,
                ),
              ),
              SizedBox(height: 15.v),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.h),
                  child: Text(
                    "Clear",
                    style: CustomTextStyles.labelSmallPink900,
                  ),
                ),
              ),
              SizedBox(height: 11.v),
              Expanded(
                child: _buildFrameOne(context),
              ),
              SizedBox(height: 20.v)
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 42.v,
      leadingWidth: 27.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 12.h,
          top: 11.v,
          bottom: 12.v,
        ),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Notifications",
      ),
      actions: [
        GestureDetector(
          // Wrap with GestureDetector to make it tappable

          child: AppbarTrailingImage(
            onTap: () {
              Navigator.pushNamed(context, '/admin_settings_screen');
            },
            imagePath: ImageConstant.imgGroup17,
            margin: EdgeInsets.fromLTRB(13.h, 8.v, 13.h, 11.v),
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  Widget _buildFrameOne(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 3.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.v,
          );
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: 15.v, horizontal: 20.h), // Adjust padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  15.0), // Make rounded rectangles smaller
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: AdminNotificationItemWidget(),
          );
        },
      ),
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}

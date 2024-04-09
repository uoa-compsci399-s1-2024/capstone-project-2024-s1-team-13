import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/notifications_item_widget_support.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';



class NotificationsSupport extends StatelessWidget {
  const NotificationsSupport({Key? key})
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

// Inside the CustomAppBar widget
/// Inside the CustomAppBar widget
PreferredSizeWidget _buildAppBar(BuildContext context) {
  // Check if the current route is not FrameThreeScreen
  if (ModalRoute.of(context)!.settings.name != AppRoutes.traineeTaskAnalysis) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 38.h,
      leading: IconButton(
      icon: Icon(Icons.chevron_left, color: Colors.white, size:50), // Use the back icon
      onPressed: () {
        // Navigate back to the previous screen
        Navigator.pop(context);
      },
      ),
      centerTitle: true,
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgSettings,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: 16.h,
          ),
          child: IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 50),
            onPressed: () {
              // Navigate to the settings screen
              Navigator.pushNamed(context, '/support_staff_settings');
            },
          ),
        ),
      ],
      styleType: Style.bgShadow,
      //styleType: Style.bgFill,
    );
  } else {
    // Return null if the route is FrameThreeScreen to hide the app bar
    return PreferredSize(
      preferredSize: Size.zero,
      child: SizedBox(),
    );
  }
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
            return NotificationsItemWidgetSupport();
          },
        ),
      ),
    );
  }


/// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }



}

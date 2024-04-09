import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context), // Using CustomAppBar here
        body: SizedBox(
          width: 390.h,
          child: Column(
            children: [
              SizedBox(height: 5.v),
              Container(
                width: 384.h,
                margin: EdgeInsets.only(right: 5.h),
                decoration: AppDecoration.fillWhiteA,
                child: Column(
                  children: [
                    SizedBox(height: 21.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 40.h,
                          right: 7.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 32.v,
                                  bottom: 32.v,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 302.h,
                                      child: Text(
                                        "Good morning, Support!",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                    ),
                                    SizedBox(height: 32.v),
                                    Column(
                                      children: [
                                        CustomElevatedButton(
                                          height: 58.v,
                                          text: "Trainees",
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.adminTraineeView);
                                            // Handle button 1 press
                                          },
                                        ),
                                        SizedBox(height: 20.v),
                                        CustomElevatedButton(
                                          height: 58.v,
                                          text: "Tasks",
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.adminTask);
                                            // Handle button 2 press
                                          },
                                        ),
                                        SizedBox(height: 20.v),
                                        CustomElevatedButton(
                                          height: 58.v,
                                          text: "Recipes",
                                          onPressed: () {
                                            // Handle button 3 press
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 382.v,
                              width: 11.h,
                              margin: EdgeInsets.only(left: 21.h),
                              decoration: BoxDecoration(
                                color: appTheme.gray5001,
                                borderRadius: BorderRadius.circular(
                                  5.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 94.v),
                  ],
                ),
              ),
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
      leading: GestureDetector(
        onTap: () {
          // Navigate to a specific screen when the notifications icon is tapped
          Navigator.pushNamed(context, AppRoutes.adminNotifications);
        },
        child: Icon(
          Icons.notifications, // Use the notifications icon
          color: Colors.white, // Set the icon color
          size: 40, // Set the icon size
        ),
      ),
      centerTitle: true,
      title: AppbarTitleImage(
          imagePath:
              'assets/images/img_group_32.svg'), // Using default title image app bar
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right:
                8.0, // Adjust the padding to move the settings icon to the left
          ),
          child: GestureDetector(
            onTap: () {
              // Navigate to a specific screen when the settings icon is tapped
              Navigator.pushNamed(context, AppRoutes.adminSettingsScreen);
            },
            child: Icon(
              Icons.settings, // Use the settings icon
              color: Colors.white, // Set the icon color
              size: 40, // Set the icon size
            ),
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}

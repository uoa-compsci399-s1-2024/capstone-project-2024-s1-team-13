import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class FrameOneScreen extends StatelessWidget {
  const FrameOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    _buildAppBar(context),
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
                                  top: 116.v,
                                  bottom: 85.v,
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
                                    CustomElevatedButton(
                                      height: 58.v,
                                      text: "Select Trainee",
                                      margin: EdgeInsets.only(
                                        left: 5.h,
                                        right: 15.h,
                                      ),
                                      buttonTextStyle: theme.textTheme.titleLarge!,
                                      onPressed: () {
                                        Navigator.pushNamed(context, AppRoutes.adminSupportLoginScreen);
                                      },
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.notificationsScreen);
          },
          label: Text('Notifications'),
          icon: Icon(Icons.notifications),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: GestureDetector(
        onTap: () {
          // You can keep the bell icon button's functionality here
          // Or replace it with any other action
        },
        child: AppbarLeadingImage(
          imagePath: ImageConstant.imgIconBell,
          margin: EdgeInsets.only(
            left: 22.h,
            top: 14.v,
            bottom: 14.v,
          ),
        ),
      ),
      centerTitle: true,
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgSettings,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup32,
          margin: EdgeInsets.fromLTRB(21.h, 11.v, 21.h, 13.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}

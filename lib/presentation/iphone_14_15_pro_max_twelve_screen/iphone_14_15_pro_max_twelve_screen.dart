import 'package:tetuhi/widgets/app_bar/custom_app_bar.dart';
import 'package:tetuhi/widgets/app_bar/appbar_leading_image.dart';
import 'package:tetuhi/widgets/app_bar/appbar_title_image.dart';
import 'package:tetuhi/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tetuhi/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tetuhi/core/app_export.dart';

class Iphone1415ProMaxTwelveScreen extends StatelessWidget {
  const Iphone1415ProMaxTwelveScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 24.v,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 130.v,
                    bottom: 493.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 338.h,
                        child: Text(
                          "Good morning, Support!",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                      SizedBox(height: 35.v),
                      CustomElevatedButton(
                        height: 65.v,
                        text: "Select Trainee",
                        margin: EdgeInsets.only(
                          left: 6.h,
                          right: 17.h,
                        ),
                        buttonStyle: CustomButtonStyles.outlinePrimaryTL33,
                        buttonTextStyle: CustomTextStyles.titleLargeWhiteA70023,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 24.h,
                  bottom: 398.v,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 3.h,
                  vertical: 161.v,
                ),
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder6,
                ),
                child: SizedBox(
                  height: 105.v,
                  child: VerticalDivider(
                    width: 4.h,
                    thickness: 4.v,
                  ),
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
      leadingWidth: 47.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgIconBell,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 15.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgSettings,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup32,
          margin: EdgeInsets.fromLTRB(18.h, 12.v, 18.h, 14.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }
}

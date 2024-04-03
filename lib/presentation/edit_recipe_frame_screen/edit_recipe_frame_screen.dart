import 'package:sen_s_application1/widgets/custom_text_form_field.dart';
import 'package:sen_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:sen_s_application1/widgets/custom_icon_button.dart';
import 'package:sen_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:sen_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class EditRecipeFrameScreen extends StatelessWidget {
  EditRecipeFrameScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController macaronsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 372.h,
          child: Column(
            children: [
              _buildTwentyEight(context),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 7.v,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 9.v,
                          bottom: 30.v,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStepOneComponent(context),
                            SizedBox(height: 15.v),
                            _buildStepTwoComponent(context),
                            SizedBox(height: 16.v),
                            CustomElevatedButton(
                              text: "+ ADD STEP",
                              margin: EdgeInsets.only(left: 4.h),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 5.h,
                        bottom: 37.v,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.h,
                        vertical: 114.v,
                      ),
                      decoration: AppDecoration.fillErrorContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: SizedBox(
                        height: 100.v,
                        child: VerticalDivider(
                          width: 3.h,
                          thickness: 3.v,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTwentyEight(BuildContext context) {
    return SizedBox(
      height: 150.v,
      width: 364.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 6.v),
              padding: EdgeInsets.symmetric(
                horizontal: 25.h,
                vertical: 16.v,
              ),
              decoration: AppDecoration.outlinePrimary1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 63.v,
                      bottom: 18.v,
                    ),
                    child: CustomTextFormField(
                      width: 233.h,
                      controller: macaronsController,
                      hintText: "Macarons",
                      textInputAction: TextInputAction.done,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 9.h,
                        vertical: 6.v,
                      ),
                      borderDecoration: TextFormFieldStyleHelper.fillGrayTL15,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle167,
                    height: 67.adaptSize,
                    width: 67.adaptSize,
                    radius: BorderRadius.circular(
                      8.h,
                    ),
                    margin: EdgeInsets.only(
                      top: 44.v,
                      right: 3.h,
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomAppBar(
            leadingWidth: 32.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeft,
              margin: EdgeInsets.only(
                left: 15.h,
                top: 14.v,
                bottom: 15.v,
              ),
              onTap: () {
                onTapArrowLeft(context);
              },
            ),
            centerTitle: true,
            title: AppbarTitle(
              text: "Edit Recipe",
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgAddRecipeBtnComponent,
                margin: EdgeInsets.fromLTRB(26.h, 9.v, 26.h, 10.v),
                onTap: () {
                  onTapImage(context);
                },
              )
            ],
            styleType: Style.bgShadow,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStepOneComponent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 35.v,
            width: 321.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle163,
                  height: 35.v,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 303.h,
                    margin: EdgeInsets.fromLTRB(12.h, 8.v, 6.h, 1.v),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 21.adaptSize,
                          margin: EdgeInsets.only(bottom: 2.v),
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.fillGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                          ),
                          child: Text(
                            "1",
                            style: CustomTextStyles.labelLargeOnError,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.h,
                            top: 2.v,
                            bottom: 4.v,
                          ),
                          child: Text(
                            "STEP ONE",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 4.v),
                          child: CustomIconButton(
                            height: 20.v,
                            width: 19.h,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgUserPrimarycontainer,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: _buildThirty(
              context,
              addSugarAndBeat:
                  "Add cream of tartar to the egg whites and beat. ",
              image: ImageConstant.imgImgPlaceholderComponent,
            ),
          ),
          SizedBox(height: 14.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStepTwoComponent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 35.v,
            width: 321.h,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 35.v,
                    width: 321.h,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle163,
                          height: 35.v,
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 12.h,
                              bottom: 4.v,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 21.adaptSize,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.h,
                                    vertical: 2.v,
                                  ),
                                  decoration: AppDecoration.fillGray.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder10,
                                  ),
                                  child: Text(
                                    "2",
                                    style: CustomTextStyles.labelLargeOnError,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.h,
                                    top: 2.v,
                                    bottom: 2.v,
                                  ),
                                  child: Text(
                                    "STEP TWO",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 3.h),
                  child: CustomIconButton(
                    height: 20.v,
                    width: 19.h,
                    alignment: Alignment.bottomRight,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgUserPrimarycontainer,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: _buildThirty(
              context,
              addSugarAndBeat:
                  "Add sugar and beat until stiff glossy peaks form|",
              image: ImageConstant.imgImgPlaceholderComponent67x66,
            ),
          ),
          SizedBox(height: 14.v)
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildThirty(
    BuildContext context, {
    required String addSugarAndBeat,
    required String image,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 21.h,
            vertical: 13.v,
          ),
          decoration: AppDecoration.fillGray200.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder31,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.v),
              SizedBox(
                width: 167.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Add sugar and beat until stiff glossy peaks form",
                        style: CustomTextStyles.labelMediumff000000,
                      ),
                      TextSpan(
                        text: "|",
                        style: theme.textTheme.bodySmall,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
        CustomImageView(
          imagePath: image,
          width: 66.h,
          radius: BorderRadius.circular(
            8.h,
          ),
          margin: EdgeInsets.only(left: 9.h),
        )
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the editRecipesFrameScreen when the action is triggered.
  onTapImage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editRecipesFrameScreen);
  }
}

import 'package:sen_s_application1/widgets/custom_icon_button.dart';
import 'package:sen_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:sen_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:sen_s_application1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:sen_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class EditRecipesFrameScreen extends StatelessWidget {
  EditRecipesFrameScreen({Key? key})
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
          height: 483.v,
          width: 372.h,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 10.v,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 10.v,
                  ),
                  child: Text(
                    "Recipes",
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgFilterComponent,
                height: 26.adaptSize,
                width: 26.adaptSize,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(
                  top: 53.v,
                  right: 27.h,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 51.v,
                  ),
                  child: CustomSearchView(
                    width: 277.h,
                    controller: searchController,
                    hintText: "Search Recipes",
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 76.v),
                        child: Column(
                          children: [
                            _buildFortyThree(context),
                            SizedBox(height: 3.v),
                            _buildFortyFour(context),
                            SizedBox(height: 1.v),
                            _buildFortyFive(context)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 8.h,
                        bottom: 15.v,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.h,
                        vertical: 167.v,
                      ),
                      decoration: AppDecoration.fillErrorContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: SizedBox(
                        height: 90.v,
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 49.v,
      leadingWidth: 32.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 15.h,
          top: 14.v,
          bottom: 14.v,
        ),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Edit Recipes",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgClose,
          margin: EdgeInsets.fromLTRB(16.h, 16.v, 16.h, 15.v),
          onTap: () {
          onTapAddButtonRight(context);
        },
        )
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildFortyThree(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 117.v,
          width: 155.h,
          margin: EdgeInsets.only(top: 1.v),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              CustomIconButton(
                height: 20.adaptSize,
                width: 20.adaptSize,
                alignment: Alignment.bottomRight,
                child: CustomImageView(
                  imagePath: ImageConstant.imgUserPrimarycontainer,
                ),
              ),
              _buildRecipeComponent(
                context,
                rECIPE: "RECIPE",
              )
            ],
          ),
        ),
        _buildForty(
          context,
          rECIPE: "RECIPE",
          onTapRecipeComponent: () {
            onTapRecipeComponent(context);
          },
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildFortyFour(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 115.v,
          width: 154.h,
          margin: EdgeInsets.only(bottom: 3.v),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              _buildRecipeComponent(
                context,
                rECIPE: "RECIPE",
              ),
              CustomIconButton(
                height: 20.adaptSize,
                width: 20.adaptSize,
                alignment: Alignment.bottomRight,
                child: CustomImageView(
                  imagePath: ImageConstant.imgUserPrimarycontainer,
                ),
              )
            ],
          ),
        ),
        _buildForty(
          context,
          rECIPE: "RECIPE",
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildFortyFive(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 122.v,
            width: 152.h,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                CustomIconButton(
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  alignment: Alignment.bottomRight,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgUserPrimarycontainer,
                  ),
                ),
                _buildRecipeComponent(
                  context,
                  rECIPE: "RECIPE",
                )
              ],
            ),
          ),
          Container(
            height: 116.v,
            width: 151.h,
            margin: EdgeInsets.only(bottom: 6.v),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                _buildRecipeComponent(
                  context,
                  rECIPE: "RECIPE",
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgUser,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  alignment: Alignment.bottomRight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRecipeComponent(
    BuildContext context, {
    required String rECIPE,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: appTheme.gray400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Container(
        height: 109.v,
        width: 147.h,
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder21,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle136,
              height: 31.v,
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 6.v),
                child: Text(
                  rECIPE,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.primaryContainer,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildForty(
    BuildContext context, {
    required String rECIPE,
    Function? onTapRecipeComponent,
  }) {
    return SizedBox(
      height: 119.v,
      width: 152.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () {
              onTapRecipeComponent?.call();
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: appTheme.gray400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder21,
                ),
                child: Container(
                  height: 109.v,
                  width: 147.h,
                  decoration: AppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder21,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle136,
                        height: 31.v,
                        alignment: Alignment.bottomCenter,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.v),
                          child: Text(
                            rECIPE,
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomIconButton(
            height: 20.adaptSize,
            width: 20.adaptSize,
            alignment: Alignment.bottomRight,
            child: CustomImageView(
              imagePath: ImageConstant.imgUserPrimarycontainer,
            ),
          )
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  // Navigates to the addRecipeFrameScreen when the action is triggered.
  onTapAddButtonRight(BuildContext context){
    Navigator.pushNamed(context, AppRoutes.addRecipeFrameScreen);
  }

  /// Navigates to the editRecipeFrameScreen when the action is triggered.
  onTapRecipeComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editRecipeFrameScreen);
  }
}

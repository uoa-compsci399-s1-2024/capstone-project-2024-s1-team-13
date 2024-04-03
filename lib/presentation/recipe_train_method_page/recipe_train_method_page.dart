import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'widgets/recipetrainmethod_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class RecipeTrainMethodPage extends StatelessWidget {
  const RecipeTrainMethodPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: 382.h,
          padding: EdgeInsets.symmetric(horizontal: 39.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 34.v),
              Text(
                "Select learning method",
                style: CustomTextStyles.titleLargePrimary,
              ),
              SizedBox(height: 17.v),
              _buildRecipeTrainMethod(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 34.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgBackChevronIcon,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 14.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Recipes",
      ),
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildRecipeTrainMethod(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 154.v,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 9.h,
            );
          },
          itemCount: 1,
          itemBuilder: (context, index) {
            return RecipetrainmethodItemWidget();
          },
        ),
      ),
    );
  }
}

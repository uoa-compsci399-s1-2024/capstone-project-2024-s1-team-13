import 'package:istefat_s_application1/presentation/recipe_train_method_page/recipe_train_method_page.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar.dart';





class TaskRecipeScreen extends StatelessWidget {
  TaskRecipeScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: 382.h,
          padding: EdgeInsets.symmetric(
            horizontal: 31.h,
            vertical: 28.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 28.v),
              CustomElevatedButton(
                height: 127.v,
                text: "TASKS",
              ),
              SizedBox(height: 28.v),
              CustomElevatedButton(
                height: 127.v,
                text: "RECIPES",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.recipesScreen); 
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 15.h,
            right: 20.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgIconBell,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 12.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgSettings,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup17,
          margin: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 11.v,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return "/";
      case BottomBarEnum.Task:
        return "/";
      case BottomBarEnum.Recipes:
        return AppRoutes.recipeTrainMethodPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.recipeTrainMethodPage:
        return RecipeTrainMethodPage();
      default:
        return DefaultWidget();
    }
  }
}

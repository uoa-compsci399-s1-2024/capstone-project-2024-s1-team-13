import 'package:istefat_s_application1/presentation/trainees/recipe_train_method_page/recipe_train_method_page.dart';
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
                onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.taskScreen);
                }
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
      leading: IconButton(
          icon: Icon(Icons.notifications, color: Colors.white, size: 40), // Make the icon white
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.notificationsScreen);
            },
          ),
      
      centerTitle: true,
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgSettings,

      ),
      actions: [AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup32,
          margin: EdgeInsets.fromLTRB(21.h, 11.v, 21.h, 13.v),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  

  
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.of(context)?.pushNamed(getCurrentRoute(type));
      }, selectedIndex: 0,
    );
  }
  



  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.taskRecipeScreen;
      case BottomBarEnum.Task:
        return "/";
      case BottomBarEnum.Recipes:
        return AppRoutes.recipesScreen;
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
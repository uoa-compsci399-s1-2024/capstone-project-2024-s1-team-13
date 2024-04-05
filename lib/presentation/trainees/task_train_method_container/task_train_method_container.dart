import 'package:flutter/material.dart';
import 'package:istefat_s_application1/presentation/trainees/recipe_train_method_page/recipe_train_method_page.dart';
import 'package:istefat_s_application1/presentation/trainees/task_screen/task_screen.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar.dart';
import 'package:istefat_s_application1/core/app_export.dart';

import '../recipes_screen/recipes_screen.dart';
import '../task_recipe_screen/task_recipe_screen.dart';

class TaskTrainMethodContainerScreen extends StatelessWidget {
  TaskTrainMethodContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.taskRecipeScreen,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 25.h,
            right: 11.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }
  
  // Section Widget
  
  

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        navigatorKey.currentState?.pushNamed(getCurrentRoute(type)); // Use navigatorKey for navigation
      },
      selectedIndex: 1,
    );
  }

  

  

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.taskRecipeScreen;
      case BottomBarEnum.Task:
        return AppRoutes.taskScreen;
      case BottomBarEnum.Recipes:
        return AppRoutes.recipesScreen;
      default:
        return "/";
    }
  }



  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.taskRecipeScreen:
        return TaskRecipeScreen();
      case AppRoutes.recipesScreen:
        return RecipesScreen();
      case AppRoutes.taskScreen:
        return TaskScreen();
        
      default:
        return DefaultWidget();
    }
  }

}
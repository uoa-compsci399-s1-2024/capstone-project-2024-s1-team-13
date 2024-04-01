import 'package:flutter/material.dart';
import '../presentation/task_recipe_screen/task_recipe_screen.dart';
import '../presentation/welcome_screen/welcome_screen.dart';
import '../presentation/admin_support_login_screen/admin_support_login_screen.dart';
import '../presentation/frame_one_screen/frame_one_screen.dart';
import '../presentation/recipes_screen/recipes_screen.dart';
import '../presentation/notifications_screen/notifications_screen.dart';
import '../presentation/recipe_train_method_container_screen/recipe_train_method_container_screen.dart';
import '../presentation/macarons_recipe_screen/macarons_recipe_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String welcomeScreen = '/welcome_screen';

  static const String adminSupportLoginScreen = '/admin_support_login_screen';

  static const String frameOneScreen = '/frame_one_screen';

  static const String appNavigationScreen = '/app_navigation_screen';




  static const String taskRecipeScreen = '/task_recipe_screen';

  static const String recipesScreen = '/recipes_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String recipeTrainMethodPage = '/recipe_train_method_page';

  static const String recipeTrainMethodContainerScreen = '/recipe_train_method_container_screen';

  static const String macaronsRecipeScreen = '/macarons_recipe_screen';

 


  static Map<String, WidgetBuilder> routes = {
    welcomeScreen: (context) => WelcomeScreen(),
    adminSupportLoginScreen: (context) => AdminSupportLoginScreen(),
    frameOneScreen: (context) => FrameOneScreen(),
    taskRecipeScreen: (context) => TaskRecipeScreen(),
    recipesScreen: (context) => RecipesScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    recipeTrainMethodContainerScreen: (context) => RecipeTrainMethodContainerScreen(),
    macaronsRecipeScreen: (context) => MacaronsRecipeScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}

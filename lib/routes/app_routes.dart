import 'package:flutter/material.dart';
import '../presentation/add_recipe_frame_screen/add_recipe_frame_screen.dart';
import '../presentation/edit_recipe_frame_screen/edit_recipe_frame_screen.dart';
import '../presentation/edit_recipes_frame_screen/edit_recipes_frame_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String addRecipeFrameScreen = '/add_recipe_frame_screen';

  static const String editRecipeFrameScreen = '/edit_recipe_frame_screen';

  static const String editRecipesFrameScreen = '/edit_recipes_frame_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    addRecipeFrameScreen: (context) => AddRecipeFrameScreen(),
    editRecipeFrameScreen: (context) => EditRecipeFrameScreen(),
    editRecipesFrameScreen: (context) => EditRecipesFrameScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}

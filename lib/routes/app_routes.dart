import 'package:flutter/material.dart';
import 'package:istefat_s_application1/presentation/trainees/task_train_method_page/task_train_method.dart';
import '../presentation/trainees/dishes/dishes.dart';
import '../presentation/support/notifications_screen_support/notifications_screen_support.dart';
import '../presentation/trainees/recipe_train_method_page/recipe_train_method_page.dart';
import '../presentation/trainees/task_recipe_screen/task_recipe_screen.dart';
import '../presentation/trainees/task_screen/task_screen.dart';
import '../presentation/trainees/recipes_screen/recipes_screen.dart';
import '../presentation/welcome_screen/welcome_screen.dart';
import '../presentation/admin_support_login_screen/admin_support_login_screen.dart';
import '../presentation/support/frame_one_screen/frame_one_screen.dart';
import '../presentation/trainees/notifications_screen/notifications_screen.dart';
import '../presentation/trainees/recipe_train_method_container_screen/recipe_train_method_container_screen.dart';
import '../presentation/trainees/macarons_recipe_screen/macarons_recipe_screen.dart';
import '../presentation/admin/add_recipe_frame_screen/add_recipe_frame_screen.dart';
import '../presentation/admin/edit_recipe_frame_screen/edit_recipe_frame_screen.dart';
import '../presentation/admin/edit_recipes_frame_screen/edit_recipes_frame_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:istefat_s_application1/presentation/support/support_trainee_profile_page/support_trainee_profile_page.dart';
import '../presentation/support/task_analysis_mood_screen/task_analysis_mood_screen.dart';
import '../presentation/support/task_analysis_judgecall_screen/task_analysis_judgecall_screen.dart';
import '../presentation/support/task_analysis_notes_screen/task_analysis_notes_screen.dart';
import '../presentation/support/profile_container_screen/profile_container_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/support/support_trainee_progress_screen/support_trainee_progress_screen.dart';
import '../presentation/support/support_trainee_notes_page/support_trainee_notes_page.dart';
import '../presentation/support/support_trainee_notes_container_screen/support_trainee_notes_container_screen.dart';
import '../presentation/support/support_add_notes_screen/support_add_notes_screen.dart';
import '../presentation/support/support_edit_notes_screen/support_edit_notes_screen.dart';


class AppRoutes {
  static const String welcomeScreen = '/welcome_screen';

  static const String adminSupportLoginScreen = '/admin_support_login_screen';

  static const String frameOneScreen = '/frame_one_screen';

  static const String appNavigationScreen = '/app_navigation_screen';




  static const String taskRecipeScreen = '/task_recipe_screen';

  static const String recipesScreen = '/recipes_screen';

  static const String taskScreen = '/task_screen';

  static const String notificationsScreen = '/notifications_screen';
  static const String notificationsScreenSupport = '/notifications_screen_support';


  static const String recipeTrainMethodPage = '/recipe_train_method_page';

  static const String taskTrainMethodPage = '/task_train_method_page';
  
  static const String recipeTrainMethodContainerScreen = '/recipe_train_method_container_screen';

  static const String macaronsRecipeScreen = '/macarons_recipe_screen';


  static const String addRecipeFrameScreen = '/add_recipe_frame_screen';

  static const String editRecipeFrameScreen = '/edit_recipe_frame_screen';

  static const String editRecipesFrameScreen = '/edit_recipes_frame_screen';

  static const String dishes = '/dishes';


  static const String taskAnalysisMoodScreen = '/task_analysis_mood_screen';

  static const String taskAnalysisJudgecallScreen = '/task_analysis_judgecall_screen';

  static const String taskAnalysisNotesScreen = '/task_analysis_notes_screen';

  static const String supportTraineeProfilePage = '/support_trainee_profile_page';

  static const String profileContainerScreen = '/profile_container_screen';


  static const String supportTraineeProgressScreen = '/support_trainee_progress_screen';

  static const String supportTraineeNotesPage = '/support_trainee_notes_page';

  static const String supportTraineeNotesContainerScreen = '/support_trainee_notes_container_screen';

  static const String supportAddNotesScreen = '/support_add_notes_screen';

  static const String supportEditNotesScreen = '/support_edit_notes_screen';

  

  



  static Map<String, WidgetBuilder> routes = {
    welcomeScreen: (context) => WelcomeScreen(),
    adminSupportLoginScreen: (context) => AdminSupportLoginScreen(),
    frameOneScreen: (context) => FrameOneScreen(),
    taskRecipeScreen: (context) => TaskRecipeScreen(),
    recipesScreen: (context) => RecipesScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    notificationsScreenSupport: (context) => NotificationsScreenSupport(),
    recipeTrainMethodContainerScreen: (context) => RecipeTrainMethodContainerScreen(),
    recipeTrainMethodPage: (context) => RecipeTrainMethodPage(),
    taskTrainMethodPage: (context) => TaskTrainMethod(),
    macaronsRecipeScreen: (context) => MacaronsRecipeScreen(),
    addRecipeFrameScreen: (context) => AddRecipeFrameScreen(),
    editRecipeFrameScreen: (context) => EditRecipeFrameScreen(),
    editRecipesFrameScreen: (context) => EditRecipesFrameScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    taskScreen: (context) => TaskScreen(),
    dishes: (context) => Dishes(),
    taskAnalysisMoodScreen: (context) => TaskAnalysisMoodScreen(),
    taskAnalysisJudgecallScreen: (context) => TaskAnalysisJudgecallScreen(),
    taskAnalysisNotesScreen: (context) => TaskAnalysisNotesScreen(),
    profileContainerScreen: (context) => ProfileContainerScreen(),
    supportTraineeProfilePage: (context) => SupportTraineeProfilePage(),
    supportTraineeProgressScreen: (context) => SupportTraineeProgressScreen(),
    supportTraineeNotesContainerScreen: (context) =>
        SupportTraineeNotesContainerScreen(),
    supportAddNotesScreen: (context) => SupportAddNotesScreen(),
    supportEditNotesScreen: (context) => SupportEditNotesScreen(),
    supportTraineeNotesPage: (context) => SupportTraineeNotesPage()

  };
}

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
import '../presentation/support/support_trainee_progress_screen/support_trainee_progress_screen.dart';
import '../presentation/support/support_trainee_notes_page/support_trainee_notes_page.dart';
import '../presentation/support/support_trainee_notes_container_screen/support_trainee_notes_container_screen.dart';
import '../presentation/support/support_add_notes_screen/support_add_notes_screen.dart';
import '../presentation/support/support_edit_notes_screen/support_edit_notes_screen.dart';



import 'package:istefat_s_application1/presentation/support/supportTraineeSummary/support_trainee_summary.dart';
import '../presentation/support/traineeTaskAnalysis/trainee_task_analysis.dart';
import '../presentation/support/supportStaffSettings/support_staff_settings.dart';
import '../presentation/support/supportSelectTrainee/support_select_trainee.dart';
import '../presentation/support/supportTraineeSummaryContainer/support_trainee_summary_container_screen.dart';
import '../presentation/support/traineeEvaluate/trainee_evaluate_1.dart';
import '../presentation/admin/adminSettings/admin_settings_screen.dart';
import '../presentation/admin/adminNewLogin/admin_new_login.dart';
import '../presentation/admin/adminTask/admin_task_1.dart';
import '../presentation/admin/adminEditTask/admin_edit_task.dart';
import '../presentation/admin/adminNotifications/admin_notifications.dart';
import '../presentation/admin/admin_add_task/admin_add_task.dart';
import '../presentation/admin/admin_edit_trainee_details_screen/admin_edit_trainee_details_screen.dart';
import '../presentation/trainees/macaroons_auditory_screen/macaroons_auditory_screen.dart';
import '../presentation/admin/adminTraineeView/admin_trainee_view.dart';
import '../presentation/admin/admin_add_trainee_screen/admin_add_trainee_screen.dart';
import '../presentation/admin/admin_add_trainee_dialog/admin_add_trainee_dialog.dart';
import '../presentation/admin/admin_edit_trainees_screen/admin_edit_trainees_screen.dart';
import '../presentation/admin/admin_remove_trainees_dialog/admin_remove_trainees_dialog.dart';
import '../presentation/support/support_trainee_profile_container_screen/support_trainee_profile_container_screen.dart';
import '../presentation/support/notification_screen_support/notification_screen_support.dart';
import '../presentation/admin/admin_home/admin_home.dart';
import '../presentation/admin/admin_trainee_profile/admin_trainee_profile.dart';
import '../presentation/admin/admin_trainee_profile_container/admin_trainee_profile_container.dart';



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







  static const String traineeTaskAnalysis = '/trainee_task_analysis';

  static const String adminSettingsScreen = '/admin_settings_screen';

  static const String adminNewLogin = '/admin_new_login';

  static const String supportStaffSettings = '/support_staff_settings';

  static const String supportSelectTrainee = '/support_select_trainee';

  static const String supportTraineeSummary = '/support_trainee_summary';

  static const String supportTraineeSummaryContainer =
      '/support_trainee_summary_container_screen';

  static const String traineeEvaluate = '/trainee_evaluate_1';


  static const String adminTask = '/admin_task_1';

  static const String adminEditTask = '/admin_edit_task';

  static const String adminNotifications = '/admin_notifications';

  static const String adminAddTask = '/admin_add_task';

  static const String adminEditTraineeDetails =
      '/admin_edit_trainee_details_screen';


  static const String macaroonsAuditoryScreen = '/macaroons_auditory_screen';

  static const String adminTraineeView = '/admin_trainee_view';

  static const String adminAddTrainee = '/admin_add_trainee_screen';

  static const String adminAddTraineeDialog =
      '/admin_add_trainee_page_three_dialog';

  static const String adminEditTraineesScreen = '/admin_edit_trainees_screen';

  static const String adminRemoveTraineesDialog =
      '/admin_remove_trainees_dialog';


  static const String notificationSupport = '/notification_screen_support';

  static const String supportTraineeProfile = '/support_trainee_profile_page';

  static const String supportTraineeProfileContainer = '/support_trainee_profile_container_screen';

  static const String adminHome = '/admin_home';

  static const String adminTraineeProfile = '/admin_trainee_profile';

  static const String adminTraineeProfileContainer = '/admin_trainee_profile_container';







  

  



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
    supportTraineeNotesPage: (context) => SupportTraineeNotesPage(),



    traineeTaskAnalysis: (context) => TraineeTaskAnalysis(),
    supportStaffSettings: (context) => SupportStaffSettings(),
    supportSelectTrainee: (context) => SupportSelectTrainee(),
    supportTraineeSummaryContainer: (context) =>
        SupportTraineeSummaryContainer(),
    supportTraineeSummary: (context) => SupportTraineeSummary(),
    traineeEvaluate: (context) => TraineeEvaluate(),
    adminSettingsScreen: (context) => AdminSettingsScreen(),
    adminNewLogin: (context) => AdminNewLogin(),
    adminTask: (context) => AdminTask(),
    adminEditTask: (context) => AdminEditTask(),
    adminNotifications: (context) => AdminNotifications(),
    adminAddTask: (context) => AdminAddTask(),
    adminEditTraineeDetails: (context) => AdminEditTraineeDetails(),
    macaroonsAuditoryScreen: (context) => MacaroonsAuditoryScreen(),
    adminTraineeView: (context) => AdminTraineeView(),
    adminAddTrainee: (context) => AdminAddTrainee(),
    adminAddTraineeDialog: (context) => AdminAddTraineeDialog(),
    adminEditTraineesScreen: (context) => AdminEditTraineesScreen(),
    adminRemoveTraineesDialog: (context) => AdminRemoveTraineesDialog(),
    supportTraineeProfileContainer: (context) => SupportTraineeProfileContainer(),
    notificationSupport: (context) => NotificationsSupport(),
    adminHome: (context) => AdminHome(),
    adminTraineeProfileContainer: (context) => AdminTraineeProfileContainer(),
    adminTraineeProfile: (context) => AdminTraineeProfile(),




  };
}

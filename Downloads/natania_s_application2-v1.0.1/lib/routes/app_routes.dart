import 'package:flutter/material.dart';
import '../presentation/macaroons_auditory_screen/macaroons_auditory_screen.dart';
import '../presentation/support_worker_view_screen/support_worker_view_screen.dart';
import '../presentation/admin_edit_trainee_details_screen/admin_edit_trainee_details_screen.dart';
import '../presentation/admin_add_task_no_three_screen/admin_add_task_no_three_screen.dart';
import '../presentation/admin_add_tasks_screen/admin_add_tasks_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String macaroonsAuditoryScreen = '/macaroons_auditory_screen';

  static const String supportWorkerViewScreen = '/support_worker_view_screen';

  static const String adminEditTraineeDetailsScreen =
      '/admin_edit_trainee_details_screen';

  static const String adminAddTaskNoThreeScreen =
      '/admin_add_task_no_three_screen';

  static const String adminAddTasksScreen = '/admin_add_tasks_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    macaroonsAuditoryScreen: (context) => MacaroonsAuditoryScreen(),
    supportWorkerViewScreen: (context) => SupportWorkerViewScreen(),
    adminEditTraineeDetailsScreen: (context) => AdminEditTraineeDetailsScreen(),
    adminAddTaskNoThreeScreen: (context) => AdminAddTaskNoThreeScreen(),
    adminAddTasksScreen: (context) => AdminAddTasksScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}

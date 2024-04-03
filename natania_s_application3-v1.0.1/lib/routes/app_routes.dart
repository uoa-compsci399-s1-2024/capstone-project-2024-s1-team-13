import 'package:flutter/material.dart';
import '../presentation/admin_add_trainee_screen/admin_add_trainee_screen.dart';
import '../presentation/admin_edit_trainees_screen/admin_edit_trainees_screen.dart';
import '../presentation/admin_trainee_profile_container_screen/admin_trainee_profile_container_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String adminAddTraineeScreen = '/admin_add_trainee_screen';

  static const String adminEditTraineesScreen = '/admin_edit_trainees_screen';

  static const String adminTraineeProfilePage = '/admin_trainee_profile_page';

  static const String adminTraineeProfileContainerScreen =
      '/admin_trainee_profile_container_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    adminAddTraineeScreen: (context) => AdminAddTraineeScreen(),
    adminEditTraineesScreen: (context) => AdminEditTraineesScreen(),
    adminTraineeProfileContainerScreen: (context) =>
        AdminTraineeProfileContainerScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}

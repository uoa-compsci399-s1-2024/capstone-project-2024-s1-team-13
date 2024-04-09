import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Welcome",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.welcomeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "admin + support login ",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminSupportLoginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Frame One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frameOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Task + recipe",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.taskRecipeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recipes",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.recipesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifications",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.notificationsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifications",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.notificationsScreenSupport),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recipe train method - Container",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.recipeTrainMethodContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recipe train method",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.recipeTrainMethodPage),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Macarons recipe",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.macaronsRecipeScreen),
                        ),

                        _buildScreenTitle(
                          context,
                          screenTitle: "add-recipe-frame",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.addRecipeFrameScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "edit-recipe-frame",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editRecipeFrameScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "edit-recipes-frame",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editRecipesFrameScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Task_Analysis_Mood_Screen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.taskAnalysisMoodScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Task_Analysis_JudgeCall_Screen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.taskAnalysisJudgecallScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Task_Analysis_Notes",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.taskAnalysisNotesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Profile Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.profileContainerScreen),
                        ),

                        _buildScreenTitle(
                          context,
                          screenTitle: "Support Trainee Task Analysis",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.traineeTaskAnalysis),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Support Staff Settings",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.supportStaffSettings),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Support Trainee Selection",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.supportSelectTrainee),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Support Trainee Summary Container",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.supportTraineeSummaryContainer),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin Settings",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminSettingsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin new login",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminNewLogin),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin Notifications",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminNotifications),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin edit task",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminEditTask),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin task",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.adminTask),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin add task",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.adminAddTask),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin Edit Trainee Details",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminEditTraineeDetails),
                        ),
                     
                        _buildScreenTitle(
                          context,
                          screenTitle: "Macaroons Auditory Screen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.macaroonsAuditoryScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin Trainee View Home Screen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminTraineeView),
                        ),

                         _buildScreenTitle(
                          context,
                          screenTitle: "Admin Add Trainee Details",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminAddTrainee),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin Edit Trainee Screen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminEditTraineesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Support Trainee Profile",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.supportTraineeProfile),
                        ),
                    
                        _buildScreenTitle(
                              context,
                              screenTitle: "Admin Trainee Profile",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  context, AppRoutes.adminTraineeProfile),
                            ),

                        _buildScreenTitle(
                          context,
                          screenTitle: "Support Notifications",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.notificationSupport),
                        ),

                         _buildScreenTitle(
                          context,
                          screenTitle: "Admin Home",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminHome),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.primaryContainer,
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appTheme.blueGray400,
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: theme.colorScheme.primaryContainer,
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.primaryContainer,
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: appTheme.blueGray400,
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}

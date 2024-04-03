import 'package:natania_s_application3/presentation/admin_trainee_profile_page/admin_trainee_profile_page.dart';
import 'package:natania_s_application3/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AdminTraineeProfileContainerScreen extends StatelessWidget {
  AdminTraineeProfileContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.adminTraineeProfilePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.h),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

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
      case BottomBarEnum.Trainees:
        return AppRoutes.adminTraineeProfilePage;
      case BottomBarEnum.Task:
        return "/";
      case BottomBarEnum.Recipes:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.adminTraineeProfilePage:
        return AdminTraineeProfilePage();
      default:
        return DefaultWidget();
    }
  }
}

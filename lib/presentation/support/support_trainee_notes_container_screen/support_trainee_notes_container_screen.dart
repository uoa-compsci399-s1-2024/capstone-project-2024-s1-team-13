import 'package:istefat_s_application1/presentation/support/support_trainee_notes_page/support_trainee_notes_page.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportTraineeNotesContainerScreen extends StatelessWidget {
  SupportTraineeNotesContainerScreen({Key? key})
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
          initialRoute:
              AppRoutes.supportTraineeNotesPage, // May need to rerouted
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.h),
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
      }, selectedIndex: 2,
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return "/"; // To be redirected to trainee home dashboard
      case BottomBarEnum.Evaluate:
        return "/"; // To be redirected to evaluate screen
      case BottomBarEnum.Profile:
        return AppRoutes
            .supportTraineeNotesPage; // should be changed to trainee profile !
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.supportTraineeNotesPage:
        return SupportTraineeNotesPage();
      default:
        return DefaultWidget();
    }
  }
}

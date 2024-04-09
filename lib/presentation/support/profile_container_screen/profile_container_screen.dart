import 'package:istefat_s_application1/presentation/support/support_trainee_profile_page/support_trainee_profile_page.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ProfileContainerScreen extends StatelessWidget {
  ProfileContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.supportTraineeProfilePage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                  pageBuilder: (ctx, ani, ani1) =>
                      getCurrentPage(routeSetting.name!),
                  transitionDuration: Duration(seconds: 0),
                ),
              ),
              SizedBox(height: 20.v)
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 15.h,
            right: 19.h,
          ),
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
        return "/";
      case BottomBarEnum.Evaluate:
        return "/";
      case BottomBarEnum.Profile:
        return AppRoutes.supportTraineeProfilePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.supportTraineeProfilePage:
        return SupportTraineeProfilePage();
      default:
        return DefaultWidget();
    }
  }
}

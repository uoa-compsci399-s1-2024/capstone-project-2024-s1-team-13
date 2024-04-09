import 'package:istefat_s_application1/presentation/support/support_trainee_profile_page/support_trainee_profile_page.dart';
import 'package:istefat_s_application1/presentation/support/supportTraineeSummary/support_trainee_summary.dart';
import 'package:istefat_s_application1/presentation/support/traineeEvaluate/trainee_evaluate_1.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar_support.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportTraineeSummaryContainer extends StatelessWidget {
  SupportTraineeSummaryContainer({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context), // Use the custom app bar
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.supportTraineeSummary,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 13.h,
            right: 19.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
// Inside the CustomAppBar widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Check if the current route is not FrameThreeScreen
    if (ModalRoute.of(context)!.settings.name !=
        AppRoutes.traineeTaskAnalysis) {
      return CustomAppBar(
        height: 52.v,
        leadingWidth: 38.h,
        leading: IconButton(
          // Change from AppbarLeadingImage to IconButton
          icon: Icon(Icons.notifications,
              color: Colors.white, size: 50), // Use the notifications icon
          onPressed: () {
            // Navigate to the notifications screen
            Navigator.pushNamed(context, '/notifications_screen_support');
          },
        ),
        centerTitle: true,
        title: AppbarTitleImage(
          imagePath: ImageConstant.imgSettings,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 16.h,
            ), // Add margin between edge of screen and icon
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.white, size: 50),
              onPressed: () {
                // Navigate to the settings screen
                Navigator.pushNamed(context, '/support_staff_settings');
              },
            ),
          ),
        ],
        styleType: Style.bgShadow,
        //styleType: Style.bgFill,
      );
    } else {
      // Return null if the route is FrameThreeScreen to hide the app bar
      return PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      );
    }
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
        return AppRoutes.supportTraineeSummary;
      case BottomBarEnum.Evaluate:
        return AppRoutes.traineeEvaluate;
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      
      case AppRoutes.traineeEvaluate:
        return TraineeEvaluate();
      case AppRoutes.supportTraineeProfile:
        return SupportTraineeProfilePage();
      default:
        return SupportTraineeSummary();
    }
  }
}

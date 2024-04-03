import 'package:flutter/material.dart';
import 'package:istefat_s_application1/presentation/recipe_train_method_page/recipe_train_method_page.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class RecipeTrainMethodContainerScreen extends StatelessWidget {
  RecipeTrainMethodContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.recipeTrainMethodPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 25.h,
            right: 11.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
  return CustomBottomBar(
    onItemSelected: (index) {
      final type = BottomBarEnum.values[index];
      final currentRoute = getCurrentRoute(type);

      // If already on the desired route, do nothing
      if (ModalRoute.of(context)?.settings.name == currentRoute) {
        return;
      }

      // If the selected route is the "Recipes" tab, navigate to it directly
      if (type == BottomBarEnum.Recipes) {
        Navigator.pushNamed(context, currentRoute);
        return;
      }

      // For other items, clear the navigation stack and navigate to the selected route
      Navigator.pushNamedAndRemoveUntil(
        context,
        currentRoute,
        (route) => false, // Clear the stack
      );
    },
  );
}

  

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.taskRecipeScreen;
      case BottomBarEnum.Task:
        return "/";
      case BottomBarEnum.Recipes:
        return AppRoutes.recipeTrainMethodPage;
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.recipeTrainMethodPage:
        return RecipeTrainMethodPage();
      default:
        return DefaultWidget();
    }
  }
}
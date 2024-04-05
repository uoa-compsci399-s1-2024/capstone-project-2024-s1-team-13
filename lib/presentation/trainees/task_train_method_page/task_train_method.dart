import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'widgets/task_train_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';


class TaskTrainMethod extends StatelessWidget {
  const TaskTrainMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 34.h,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.taskScreen); // Navigate to the recipeTrainMethodPage
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Task Train Method",
      ),
      styleType: Style.bgShadow,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: 382.h,
      padding: EdgeInsets.symmetric(horizontal: 39.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 34.v),
          Text(
            "Select learning method",
            style: CustomTextStyles.titleLargePrimary,
          ),
          SizedBox(height: 17.v),
          _buildRecipeTrainMethod(context),
        ],
      ),
    );
  }

  Widget _buildRecipeTrainMethod(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 154.v,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(width: 9.h);
          },
          itemCount: 1,
          itemBuilder: (context, index) {
            return tasktrainmethodItemWidget();
          },
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(context, getCurrentRoute(type));
      },
      selectedIndex: 1, // Index of the "Recipes" tab
    );
  }

  

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.taskRecipeScreen;
      case BottomBarEnum.Task:
        return AppRoutes.taskScreen;
      case BottomBarEnum.Recipes:
        return AppRoutes.recipesScreen;
      default:
        return "/";
    }
  }
}
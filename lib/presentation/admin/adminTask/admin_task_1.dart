import 'package:istefat_s_application1/widgets/custom_bottom_bar.dart';
import 'package:istefat_s_application1/widgets/custom_icon_button.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar_admin.dart';

// ignore_for_file: must_be_immutable
class AdminTask extends StatefulWidget {
  AdminTask({Key? key}) : super(key: key);

  @override
  _adminTaskScreenState createState() => _adminTaskScreenState();
}

class _adminTaskScreenState extends State<AdminTask> {
  //int _selectedIndex = 2;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 10.v,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 10.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 51.v,
                  ),
                  child: CustomSearchView(
                    width: 277.h,
                    controller: searchController,
                    hintText: "Search Tasks",
                    alignment: Alignment.topLeft,
                  ),
                ),
                SizedBox(height: 20.v),
                Column(
                  children: [
                    _buildFortyThree(context),
                    SizedBox(height: 10.v),
                    _buildFortyFour(context),
                    SizedBox(height: 10.v),
                    _buildFortyFive(context),
                  ],
                ),
              ],
            ),
          ),
        ),
        //   bottomNavigationBar: CustomBottomBar(
        //   onChanged: (BottomBarEnum type) {
        //   _updateSelectedIndex(type); // Update selectedIndex when tab is changed
        //},
        //selectedIndex: _selectedIndex, // Pass selectedIndex to the CustomBottomBar
      ),
    );
  }

  // void _updateSelectedIndex(BottomBarEnum type) {
  // setState(() {
  // Update selectedIndex based on the selected tab
  // switch (type) {
  // case BottomBarEnum.Home:
  // _selectedIndex = 0;
  //break;
  //case BottomBarEnum.Task:
  //_selectedIndex = 1;
  //break;
  //case BottomBarEnum.Taskss:
  //_selectedIndex = 2;
  //break;
  //}
  //});
  //}

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 49.v,
      leadingWidth: 32.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 15.h,
          top: 14.v,
          bottom: 14.v,
        ),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            onTapEdit(context);
          },
          icon: Icon(Icons.edit),
          iconSize: 50,
          color: Colors.white,
        ),
      ],
      centerTitle: true,
      title: AppbarTitle(
        text: "Tasks",
      ),
      styleType: Style.bgShadow,
    );
  }

  // Widget _buildBottomBar(BuildContext context) {
  // return CustomBottomBar(
  // onChanged: (BottomBarEnum type) {
  //  Navigator.pushNamed(context, getCurrentRoute(type));
  // },
  //selectedIndex: 2, // Index of the "Taskss" tab
  //);
  //}

  //String getCurrentRoute(BottomBarEnum type) {
  //switch (type) {
  //case BottomBarEnum.Home:
  //return AppRoutes.adminHome;
  //case BottomBarEnum.Task:
  //return "/";
  //case BottomBarEnum.Taskss:
  //return AppRoutes.TaskssScreen;
  //default:
  //return "/";
  //}
  //}

  /// Section Widget
  Widget _buildFortyThree(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            child: _buildTasksComponent(
              context,
              task: "Tasks",
            ),
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: GestureDetector(
            child: _buildTasksComponent(
              context,
              task: "Tasks",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFortyFour(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            child: _buildTasksComponent(
              context,
              task: "Tasks",
            ),
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: GestureDetector(
            child: _buildTasksComponent(
              context,
              task: "Tasks",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFortyFive(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            child: _buildTasksComponent(
              context,
              task: "Tasks",
            ),
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: GestureDetector(
            child: _buildTasksComponent(
              context,
              task: "Tasks",
            ),
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildTasksComponent(
    BuildContext context, {
    required String task,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      color: appTheme.gray400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Container(
        height: 100.v,
        width: 90.h,
        decoration: AppDecoration.fillGray400.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder21,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle136,
              height: 38.v,
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 9.v),
                child: Text(
                  task,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.primaryContainer,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHome);
  }

//dont need on tap task
  onTapTasksComponent(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.admina);
  }
//}

  onTapEdit(BuildContext context) {
    // Navigate to the edit screen
    Navigator.pushNamed(context, AppRoutes.adminEditTask);
  }
}

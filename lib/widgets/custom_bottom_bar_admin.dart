import 'package:flutter/material.dart';
import '../core/app_export.dart';
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex=0;

  

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "HOME",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavTask,
      activeIcon: ImageConstant.imgNavTask,
      title: "TASK",
      type: BottomBarEnum.Task,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavRecipes,
      activeIcon: ImageConstant.imgNavRecipes,
      title: "RECIPES",
      type: BottomBarEnum.Recipes,
    )
    //need trainee too
  ];

  @override
  
  Widget build(BuildContext context) {
    return Container(
      height: 65.v,
      decoration: BoxDecoration(
        color: appTheme.gray5001,
        borderRadius: BorderRadius.circular(
          27.h,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1.84,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                handleMenuItemTap(index);
              },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 25.adaptSize,
                  width: 25.adaptSize,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 27.adaptSize,
                  width: 27.adaptSize,
                  color: appTheme.pink900,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.labelSmallPink900.copyWith(
                      color: appTheme.pink900,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        
        onTap: (index) {
          handleMenuItemTap(index);
        },
      ),
    );
    
  }
  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  void handleMenuItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (bottomMenuList[index].type) {
      case BottomBarEnum.Home:
        // Navigate to the trainee profile screen
        Navigator.pushNamed(context, AppRoutes.adminHome);
        break;
      default:
        widget.onChanged?.call(bottomMenuList[index].type);
    }
  }
}

enum BottomBarEnum {
  Home,
  Task,
  Recipes,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
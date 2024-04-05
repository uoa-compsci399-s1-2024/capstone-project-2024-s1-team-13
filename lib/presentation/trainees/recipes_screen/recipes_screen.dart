import 'package:istefat_s_application1/widgets/custom_icon_button.dart';
import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';
import 'package:istefat_s_application1/widgets/custom_bottom_bar.dart';


// ignore_for_file: must_be_immutable
class RecipesScreen extends StatefulWidget {
  RecipesScreen({Key? key}) : super(key: key);

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  int _selectedIndex = 2; 

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          height: 483.v,
          width: 372.h,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 10.v,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 10.v,
                  ),
                  
                ),
              ),
             
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 51.v,
                  ),
                  child: CustomSearchView(
                    width: 277.h,
                    controller: searchController,
                    hintText: "Search Recipes",
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 76.v),
                        child: Column(
                          children: [
                            _buildFortyThree(context),
                            SizedBox(height: 3.v),
                            _buildFortyFour(context),
                            SizedBox(height: 1.v),
                            _buildFortyFive(context)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 8.h,
                        bottom: 15.v,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.h,
                        vertical: 167.v,
                      ),
                      decoration: AppDecoration.fillErrorContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: SizedBox(
                        height: 90.v,
                        child: VerticalDivider(
                          width: 3.h,
                          thickness: 3.v,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {
            _updateSelectedIndex(type); // Update selectedIndex when tab is changed
          },
          selectedIndex: _selectedIndex, // Pass selectedIndex to the CustomBottomBar
        ),
      ),
    );
  }

  void _updateSelectedIndex(BottomBarEnum type) {
    setState(() {
      // Update selectedIndex based on the selected tab
      switch (type) {
        case BottomBarEnum.Home:
          _selectedIndex = 0;
          break;
        case BottomBarEnum.Task:
          _selectedIndex = 1;
          break;
        case BottomBarEnum.Recipes:
          _selectedIndex = 2;
          break;
      }
    });
  }


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
      centerTitle: true,
      title: AppbarTitle(
        text: "Recipes",
      ),
      
      styleType: Style.bgShadow,
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(context, getCurrentRoute(type));
      },
      selectedIndex: 2, // Index of the "Recipes" tab
    );
  }

  

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.taskRecipeScreen;
      case BottomBarEnum.Task:
        return "/";
      case BottomBarEnum.Recipes:
        return AppRoutes.recipesScreen;
      default:
        return "/";
    }
  }

  /// Section Widget
  Widget _buildFortyThree(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 20.v), // Add top margin here
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            onTapRecipeComponent(context); // Navigate to the next page
          },
          child: _buildRecipeComponent(
            context,
            rECIPE: "RECIPE",
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapRecipeComponent(context); // Navigate to the next page
          },
          child: _buildRecipeComponent(
            context,
            rECIPE: "RECIPE",
          ),
        ),
      ],
    ),
  );
}

Widget _buildFortyFour(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 10.v), // Add top margin here
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            onTapRecipeComponent(context); // Navigate to the next page
          },
          child: _buildRecipeComponent(
            context,
            rECIPE: "RECIPE",
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapRecipeComponent(context); // Navigate to the next page
          },
          child: _buildRecipeComponent(
            context,
            rECIPE: "RECIPE",
          ),
        ),
      ],
    ),
  );
}

Widget _buildFortyFive(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 10.v), // Add top margin here
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            onTapRecipeComponent(context); // Navigate to the next page
          },
          child: _buildRecipeComponent(
            context,
            rECIPE: "RECIPE",
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapRecipeComponent(context); // Navigate to the next page
          },
          child: _buildRecipeComponent(
            context,
            rECIPE: "RECIPE",
          ),
        ),
      ],
    ),
  );
}


  /// Common widget
  Widget _buildRecipeComponent(
    BuildContext context, {
    required String rECIPE,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: appTheme.gray400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder21,
      ),
      child: Container(
        height: 109.v,
        width: 147.h,
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder21,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle136,
              height: 31.v,
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 6.v),
                child: Text(
                  rECIPE,
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

  /// Common widget
  Widget _buildForty(
    BuildContext context, {
    required String rECIPE,
    Function? onTapRecipeComponent,
  }) {
    return SizedBox(
      height: 119.v,
      width: 152.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () {
              onTapRecipeComponent?.call();
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: appTheme.gray400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder21,
                ),
                child: Container(
                  height: 109.v,
                  width: 147.h,
                  decoration: AppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder21,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle136,
                        height: 31.v,
                        alignment: Alignment.bottomCenter,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.v),
                          child: Text(
                            rECIPE,
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomIconButton(
            height: 20.adaptSize,
            width: 20.adaptSize,
            alignment: Alignment.bottomRight,
            child: CustomImageView(
              imagePath: ImageConstant.imgUserPrimarycontainer,
            ),
          )
        ],
      ),
    );
  }


  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.taskRecipeScreen); // Navigate to the recipeTrainMethodPage
  }

  /// Navigates to the editRecipeFrameScreen when the action is triggered.
  onTapRecipeComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recipeTrainMethodPage);
  }
}

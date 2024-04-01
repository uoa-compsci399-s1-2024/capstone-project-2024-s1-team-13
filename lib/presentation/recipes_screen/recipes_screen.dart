import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:istefat_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:istefat_s_application1/widgets/custom_search_view.dart';
import 'widgets/recipes_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 382.h,
          child: Column(
            children: [
              SizedBox(height: 23.v),
              Container(
                decoration: AppDecoration.fillWhiteA,
                child: Column(
                  children: [
                    _buildTwelve2(context),
                    SizedBox(height: 11.v),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTwelve2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 3.h),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.recipeTrainMethodContainerScreen); 
        },
        child: Text("Go to Another Screen"),
      ),
    );
  }
}

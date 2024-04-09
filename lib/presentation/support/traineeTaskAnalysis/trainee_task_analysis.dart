import 'package:istefat_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

import '../../../widgets/custom_elevated_button.dart';

class TraineeTaskAnalysis extends StatelessWidget {
  const TraineeTaskAnalysis({Key? key}) : super(key: key);

  Widget build3(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.taskAnalysisMoodScreen);
        },
        child: Text('Next'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: 340.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTwentySeven(context),
                SizedBox(height: 16.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Text(
                    "Task Analysis Evaluation",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 10.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCheckmark,
                        width: 40.h,
                        margin: EdgeInsets.only(bottom: 10.v),
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.v),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.lexendExaGray40001,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Add more content here
                SizedBox(height: 10.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCheckmark,
                        width: 40.h,
                        margin: EdgeInsets.only(bottom: 10.v),
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.v),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.lexendExaGray40001,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Add more content here
                SizedBox(height: 10.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCheckmark,
                        width: 40.h,
                        margin: EdgeInsets.only(bottom: 10.v),
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.v),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.lexendExaGray40001,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Add more content here
                SizedBox(height: 20.v),
                SizedBox(height: 20.v),
              CustomElevatedButton(
                text: "Next",
                margin: EdgeInsets.only(
                  left: 56.h,
                  right: 46.h,
                ),
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.taskAnalysisMoodScreen);
                },
              )
                
              ],
            ),
          ),
        ),
        
      ),
    );
  }

  Widget _buildTwentySeven(BuildContext context) {
    return SizedBox(
      height: 42.v,
      width: 340.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Assess",
              style: CustomTextStyles.titleMedium19,
            ),
          ),
        ],
      ),
    );
  }
  

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      leadingWidth: 34.h,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.black, size: 40),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.traineeEvaluate);
        },
        
      ),
      
      
    );
  }
}

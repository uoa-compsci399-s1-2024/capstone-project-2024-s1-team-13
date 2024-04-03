import 'package:natania_s_application2/widgets/custom_text_form_field.dart';
import 'package:natania_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:natania_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/thirteen_item_widget.dart';
import 'package:natania_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/app_export.dart';

class AdminAddTasksScreen extends StatelessWidget {
  AdminAddTasksScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController dishesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 399.h,
          child: Column(
            children: [
              _buildFortySeven(context),
              SizedBox(height: 8.v),
              _buildThirteen(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildADDSTEP(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildFortySeven(BuildContext context) {
    return SizedBox(
      height: 165.v,
      width: 399.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 7.v),
              padding: EdgeInsets.symmetric(vertical: 17.v),
              decoration: AppDecoration.outlinePrimary1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 68.v,
                      bottom: 20.v,
                    ),
                    child: CustomTextFormField(
                      width: 255.h,
                      controller: dishesController,
                      hintText: "Dishes",
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle167,
                    width: 71.h,
                    radius: BorderRadius.circular(
                      9.h,
                    ),
                    margin: EdgeInsets.only(top: 48.v),
                  ),
                ],
              ),
            ),
          ),
          CustomAppBar(
            leadingWidth: 27.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowRight,
              margin: EdgeInsets.only(
                left: 18.h,
                top: 15.v,
                bottom: 28.v,
              ),
            ),
            centerTitle: true,
            title: AppbarTitle(
              text: "Edit Task",
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgTick,
                margin: EdgeInsets.fromLTRB(38.h, 11.v, 38.h, 27.v),
              ),
            ],
            styleType: Style.bgShadow_2,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirteen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 9.h,
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 1.v,
          );
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return ThirteenItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildADDSTEP(BuildContext context) {
    return CustomElevatedButton(
      text: "+ ADD STEP",
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 21.v,
      ),
    );
  }
}

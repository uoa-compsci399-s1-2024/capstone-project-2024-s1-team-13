import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class RecipetrainmethodItemWidget extends StatelessWidget {
  const RecipetrainmethodItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154.v,
      width: 146.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle136,
            height: 32.v,
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 153.v,
              width: 146.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 153.v,
                      width: 146.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 39.h,
                        vertical: 32.v,
                      ),
                      decoration: AppDecoration.fillGray400.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder22,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgClose,
                        height: 65.v,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6.v),
                      child: Text(
                        "AUDITORY",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

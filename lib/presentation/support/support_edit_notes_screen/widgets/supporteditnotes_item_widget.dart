import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class SupporteditnotesItemWidget extends StatelessWidget {
  SupporteditnotesItemWidget({
    Key? key,
    this.onTapBtnContrast,
  }) : super(
          key: key,
        );

  VoidCallback? onTapBtnContrast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 164.v,
      width: 327.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 11.h,
                vertical: 10.v,
              ),
              decoration: AppDecoration.fillGray2.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder22,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.h,
                      top: 8.v,
                      bottom: 110.v,
                    ),
                    child: Text(
                      "General",
                      style: MyTextStyles.titleMedium2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 123.v),
                    child: IconButton(
                        icon: Icon(Icons.remove_circle_rounded),
                        iconSize: 50,
                        color: Colors.red,
                        onPressed: () {
                          onTapBtnContrast?.call();
                        }),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 21.h,
                vertical: 12.v,
              ),
              decoration: AppDecoration.fillGray2.copyWith(
                borderRadius: BorderRadiusStyle.customBorderBL22,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26.v),
                  Container(
                    width: 271.h,
                    margin: EdgeInsets.only(right: 12.h),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                      maxLines: 4, // Should be dynamic?
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelMediumPink900_1,
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

import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class selectTrainee_item_widget extends StatelessWidget {
  const selectTrainee_item_widget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 167.v,
        ),
        decoration: AppDecoration.fillErrorContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
        child: VerticalDivider(
          width: 3.h,
          thickness: 3.v,
        ),
      ),
    );
  }
}

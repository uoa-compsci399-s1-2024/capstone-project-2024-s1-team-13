import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class traineeEvaluate_item_widget extends StatelessWidget {
  const traineeEvaluate_item_widget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.h,
        vertical: 111.v,
      ),
      decoration: AppDecoration.fillErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: VerticalDivider(
        width: 2.h,
        thickness: 2.v,
      ),
    );
  }
}

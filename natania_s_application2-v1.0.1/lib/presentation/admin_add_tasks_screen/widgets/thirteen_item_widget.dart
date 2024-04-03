import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class ThirteenItemWidget extends StatelessWidget {
  const ThirteenItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.h,
        vertical: 111.v,
      ),
      decoration: AppDecoration.fillErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: VerticalDivider(
        width: 3.h,
        thickness: 3.v,
      ),
    );
  }
}

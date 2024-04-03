import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class TwelveItemWidget extends StatelessWidget {
  const TwelveItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 187.v,
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

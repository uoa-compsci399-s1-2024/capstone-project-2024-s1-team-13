import 'package:flutter/material.dart';
import 'package:natania_s_application3/core/app_export.dart';

// ignore: must_be_immutable
class TenItemWidget extends StatelessWidget {
  const TenItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 188.v,
        ),
        decoration: AppDecoration.fillGray5001.copyWith(
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

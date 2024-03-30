import 'package:flutter/material.dart';
import 'package:tetuhi/core/app_export.dart';

// ignore: must_be_immutable
class SixtythreeItemWidget extends StatelessWidget {
  const SixtythreeItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 210.v,
        ),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder6,
        ),
        child: VerticalDivider(
          width: 4.h,
          thickness: 4.v,
        ),
      ),
    );
  }
}

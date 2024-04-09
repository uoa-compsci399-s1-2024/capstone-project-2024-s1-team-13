import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class AdminTaskItemWidget extends StatelessWidget {
  const AdminTaskItemWidget({Key? key})
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
          vertical: 142.v,
        ),
        decoration: AppDecoration.fillGray400.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
        child: SizedBox(
          height: 95.v,
          child: VerticalDivider(
            width: 3.h,
            thickness: 3.v,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTrailingImage extends StatelessWidget {
  AppbarTrailingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
    this.height, 
     this.width, 
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  final int? height; // Optional height parameter
  final int? width;  //

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath,
          width: 18.h, //18 for saachas one 21 for me and width?.toDouble() for zainab
          height: height?.toDouble(), //only have this for zaianbs
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

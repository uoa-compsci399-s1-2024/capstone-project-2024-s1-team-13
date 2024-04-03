import 'package:flutter/material.dart';
import 'package:natania_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 55.v,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 55.v,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgShadow_2:
        return Container(
          height: 55.v,
          width: 399.h,
          decoration: BoxDecoration(
            color: appTheme.red400,
            borderRadius: BorderRadius.circular(
              21.h,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary,
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(
                  0,
                  1.92,
                ),
              ),
            ],
          ),
        );
      case Style.bgShadow:
        return Container(
          height: 52.v,
          width: 385.h,
          decoration: BoxDecoration(
            color: appTheme.red400,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(21.h),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary,
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(
                  0,
                  1.85,
                ),
              ),
            ],
          ),
        );
      case Style.bgShadow_1:
        return Container(
          height: 49.v,
          width: 385.h,
          decoration: BoxDecoration(
            color: appTheme.red400,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(21.h),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary,
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(
                  0,
                  3.11,
                ),
              ),
            ],
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgShadow_2,
  bgShadow,
  bgShadow_1,
}

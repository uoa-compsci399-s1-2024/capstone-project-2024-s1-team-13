import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SupportRemoveNotePopupDialog extends StatelessWidget {
  const SupportRemoveNotePopupDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 292.h,
          padding: EdgeInsets.symmetric(
            horizontal: 32.h,
            vertical: 29.v,
          ),
          decoration: AppDecoration.fillWhiteA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder22,
          ),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.v),
                Text(
                  "Remove note?",
                  style: MyTextStyles.titleMedium2,
                ),
                SizedBox(height: 19.v),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              child: Text("YES"),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 102),
                                  foregroundColor: appTheme.whiteA700,
                                  textStyle: TextStyle(
                                    fontSize: 17.fSize,
                                    fontFamily: 'Lexend Exa',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  backgroundColor: appTheme.pink900,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                onTapYES(context);
                              })),
                      Expanded(
                        child: CustomElevatedButton(
                          text: "NO",
                          margin: EdgeInsets.only(left: 5.h),
                          buttonStyle: CustomButtonStyles.outlineBlack,
                          buttonTextStyle: CustomTextStyles.titleMediumPink900,
                          onPressed: () {
                            onTapNO(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Navigation -- pending backend functionality

  onTapYES(BuildContext context) {
    Navigator.pop(context);
  } // To remove note

  onTapNO(BuildContext context) {
    Navigator.pop(context);
  } // Keep note
}

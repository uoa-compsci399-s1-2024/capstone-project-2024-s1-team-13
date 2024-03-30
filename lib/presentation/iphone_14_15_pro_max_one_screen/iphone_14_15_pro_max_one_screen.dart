import 'package:tetuhi/widgets/custom_text_form_field.dart';
import 'package:tetuhi/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tetuhi/core/app_export.dart';

// ignore: must_be_immutable
class Iphone1415ProMaxOneScreen extends StatelessWidget {
  Iphone1415ProMaxOneScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 42.h,
                  top: 107.v,
                  right: 42.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "LOG IN ",
                          style: CustomTextStyles
                              .headlineLargeLexendPrimaryContainer,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgEnter1,
                          height: 35.adaptSize,
                          width: 35.adaptSize,
                          margin: EdgeInsets.only(
                            left: 9.h,
                            bottom: 2.v,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.v),
                    Text(
                      "Please login to continue ",
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 63.v),
                    Container(
                      height: 84.v,
                      width: 118.h,
                      margin: EdgeInsets.only(left: 100.h),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgThumbsUp,
                            width: 66.h,
                            alignment: Alignment.centerRight,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgLock,
                            width: 65.h,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.v),
                    Padding(
                      padding: EdgeInsets.only(left: 90.h),
                      child: Text(
                        "Support Staff | Admin",
                        style: CustomTextStyles.labelLargeLexendDecaPink900,
                      ),
                    ),
                    SizedBox(height: 26.v),
                    Padding(
                      padding: EdgeInsets.only(left: 58.h),
                      child: Text(
                        " Email",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(height: 4.v),
                    CustomTextFormField(
                      width: 238.h,
                      controller: emailController,
                      hintText: "john@gmail.com",
                      textInputType: TextInputType.emailAddress,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 9.v),
                    Padding(
                      padding: EdgeInsets.only(left: 57.h),
                      child: Text(
                        "Password",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(height: 7.v),
                    CustomTextFormField(
                      width: 232.h,
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      alignment: Alignment.center,
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 12.v, 11.h, 12.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgFirreyecrossed,
                          height: 10.adaptSize,
                          width: 10.adaptSize,
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 35.v,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 11.v),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 57.h,
                          right: 54.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Wrong password",
                              style: CustomTextStyles
                                  .labelMediumInterErrorContainer,
                            ),
                            Text(
                              "Forgot password?",
                              style: CustomTextStyles.labelMediumInterRed30001,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 53.v),
                    CustomElevatedButton(
                      height: 40.v,
                      width: 194.h,
                      text: "Login ",
                      buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                      buttonTextStyle: theme.textTheme.titleSmall!,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

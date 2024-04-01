import 'package:istefat_s_application1/widgets/custom_text_form_field.dart';
import 'package:istefat_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:istefat_s_application1/core/app_export.dart';

class AdminSupportLoginScreen extends StatelessWidget {
  AdminSupportLoginScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: SizedBox(
                width: 390.h,
                child: Column(
                  children: [
                    SizedBox(height: 5.v),
                    Container(
                      margin: EdgeInsets.only(right: 5.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 37.h,
                        vertical: 42.v,
                      ),
                      decoration: AppDecoration.fillWhiteA,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.v),
                          Row(
                            children: [
                              Text(
                                "LOG IN ",
                                style: theme.textTheme.headlineMedium,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgEnter1,
                                height: 31.adaptSize,
                                width: 31.adaptSize,
                                margin: EdgeInsets.only(
                                  left: 8.h,
                                  bottom: 2.v,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.v),
                          Text(
                            "Please login to continue ",
                            style: theme.textTheme.titleSmall,
                          ),
                          SizedBox(height: 57.v),
                          Container(
                            height: 75.v,
                            width: 105.h,
                            margin: EdgeInsets.only(left: 89.h),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgThumbsUp,
                                  width: 59.h,
                                  alignment: Alignment.centerRight,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgLock,
                                  width: 58.h,
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Padding(
                            padding: EdgeInsets.only(left: 80.h),
                            child: Text(
                              "Support Staff | Admin",
                              style:
                                  CustomTextStyles.labelMediumLexendDecaPink900,
                            ),
                          ),
                          SizedBox(height: 23.v),
                          Padding(
                            padding: EdgeInsets.only(left: 51.h),
                            child: Text(
                              " Email",
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                          SizedBox(height: 4.v),
                          CustomTextFormField(
                            width: 213.h,
                            controller: emailController,
                            hintText: "john@gmail.com",
                            textInputType: TextInputType.emailAddress,
                            alignment: Alignment.center,
                          ),
                          SizedBox(height: 9.v),
                          Padding(
                            padding: EdgeInsets.only(left: 51.h),
                            child: Text(
                              "Password",
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                          SizedBox(height: 6.v),
                          CustomTextFormField(
                            width: 207.h,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            alignment: Alignment.center,
                            obscureText: true,
                          ),
                          SizedBox(height: 9.v),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 51.h,
                                right: 48.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Wrong password",
                                    style: theme.textTheme.labelSmall,
                                  ),
                                  Text(
                                    "Forgot password?",
                                    style: CustomTextStyles.labelSmallRed30001,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 47.v),
                          CustomElevatedButton(
                            height: 36.v,
                            width: 173.h,
                            text: "Login ",
                            buttonStyle: CustomButtonStyles.outlinePrimaryTL18,
                            buttonTextStyle: theme.textTheme.labelLarge!,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../../utils/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailCTR = TextEditingController();
  final TextEditingController _passCTR = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 84.h),
                Center(
                  child: SvgPicture.asset(AppIcons.appLogo),
                ),
                SizedBox(height: 32.h),
                Center(
                  child: CustomText(
                    text: AppStrings.signIn.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    bottom: 8.h,
                  ),
                ),
                Center(
                  child: CustomText(
                    text: AppStrings.welcomeBack.tr,
                    fontSize: 16.sp,
                    maxLine: 2,
                    bottom: 8.h,
                  ),
                ),
                SizedBox(height: 32.h),
                //=======================> Email Text Field <=====================
                CustomText(
                  text: AppStrings.email.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _emailCTR,
                  hintText: AppStrings.email.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SvgPicture.asset(AppIcons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=======================> Password Text Field <=====================
                CustomText(
                  text: AppStrings.password.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  isPassword: true,
                  controller: _passCTR,
                  hintText: AppStrings.password.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SvgPicture.asset(AppIcons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),
                //=======================> Remember Me <=====================
                _checkboxSection(),
                SizedBox(height: 32.h),
                //=======================> Sign In Button <=====================
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.offAllNamed(AppRoutes.homeScreen);
                      }
                    },
                    text: AppStrings.signIn.tr),
                SizedBox(height: 32.h),
                //=======================> Don’t have an account <=====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppStrings.donotHaveAccount.tr,
                      fontSize: 14.sp,
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signUp.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //==========================> Checkbox Section Widget <=======================
  _checkboxSection() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.greyColor,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          side: BorderSide(
            color: isChecked ? AppColors.primaryColor : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        CustomText(
          text: AppStrings.rememberMe.tr,
          fontSize: 14.sp,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.signInScreen);
          },
          child: CustomText(
            text: AppStrings.forgot_Password.tr,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

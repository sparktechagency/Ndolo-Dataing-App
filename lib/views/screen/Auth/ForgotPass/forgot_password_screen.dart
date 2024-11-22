import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailCTR = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: SvgPicture.asset(AppIcons.appLogo),
                ),
                SizedBox(height: 32.h),
                Center(
                  child: CustomText(
                    text: AppStrings.forgot_Password.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    bottom: 8.h,
                  ),
                ),
                Center(
                  child: CustomText(
                    text: AppStrings.pleaseEnterYourEmail.tr,
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

                SizedBox(height: 150.h),
                //=======================> Get OTP Button <=====================
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.offAllNamed(AppRoutes.homeScreen);
                      }
                    },
                    text: AppStrings.getOTP.tr),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

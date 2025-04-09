import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(AppIcons.appLogo),
              ),
              Center(
                child: CustomText(
                  text: AppStrings.signUpSuccess.tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  bottom: 8.h,
                ),
              ),
              Center(
                child: CustomText(
                  text: AppStrings.thankYouForSigningUp.tr,
                  fontSize: 16.sp,
                  maxLine: 2,
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Get.offAllNamed(AppRoutes.signInScreen);
                },
                child: CustomText(
                  text: AppStrings.signIn.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

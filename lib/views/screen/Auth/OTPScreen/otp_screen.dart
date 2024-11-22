import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/views/base/custom_pin_code_text_field.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: SvgPicture.asset(AppIcons.appLogo),
              ),
              SizedBox(height: 32.h),
              Center(
                child: CustomText(
                  text: AppStrings.oTP.tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  bottom: 8.h,
                ),
              ),
              Center(
                child: CustomText(
                  text: AppStrings.pleaseEnterOTP.tr,
                  fontSize: 16.sp,
                  maxLine: 2,
                  bottom: 8.h,
                ),
              ),
              SizedBox(height: 32.h),
              //=======================> Pin Code Text Field <=====================
              const CustomPinCodeTextField(),
              SizedBox(height: 32.h),
              Center(
                  child: CustomText(
                text: AppStrings.didnotReceiveCode.tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              )),
              SizedBox(height: 150.h),
              //=======================> Verify Button <=====================
              CustomButton(
                  onTap: () {
                    Get.offAllNamed(AppRoutes.otpScreen);
                  },
                  text: AppStrings.verify.tr),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_images.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 132.h),
            CustomText(
              text: AppStrings.ndolo.tr,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              fontName: 'Gotham Rounded',
              maxLine: 3,
            ),
            SizedBox(height: 12.h),
            //==================> Meet And Connect Text <=====================
            CustomText(
              text: AppStrings.meetAndConnect.tr,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              fontName: 'Gotham Rounded',
              maxLine: 3,
            ),
            SizedBox(height: 88.h),
            //==================> Connect Image <=====================
            Center(child: Image.asset(AppImages.onbording)),
            SizedBox(height: 16.h),
            //==================> Get Started Button <=====================
            const Spacer(),
            CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.signInScreen);
                },
                text: AppStrings.getStarted.tr),
            SizedBox(height: 68.h),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController _authController  = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.changePassword.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              //==========================> Current password Text Field <===================
              CustomText(
                text: AppStrings.currentPassword.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                isPassword: true,
                controller: _authController.currentPasswordCtrl,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SvgPicture.asset(AppIcons.lock),
                ),
                hintText: AppStrings.currentPassword.tr,
              ),
              SizedBox(height: 16.h),
              //==========================> New password Text Field <===================
              CustomText(
                text: AppStrings.newPassword.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                isPassword: true,
                controller: _authController.newPasswordCtrl,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SvgPicture.asset(AppIcons.lock),
                ),
                hintText: AppStrings.newPassword.tr,
              ),
              SizedBox(height: 16.h),
              //==========================> Confirm Password Text Field <===================
              CustomText(
                text: AppStrings.confirmPassword.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                isPassword: true,
                controller: _authController.confirmPassController,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SvgPicture.asset(AppIcons.lock),
                ),
                hintText: AppStrings.confirmPassword.tr,
              ),
              SizedBox(height: 16.h),
              //==========================> Forgot Password Text Field <===================
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgotPasswordScreen);
                  },
                  child: CustomText(
                    text: AppStrings.forgot_Password.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 268.h),
              //==========================> Update Password Button <=======================
              CustomButton(
                onTap: () {},
                text: AppStrings.updatePassword.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

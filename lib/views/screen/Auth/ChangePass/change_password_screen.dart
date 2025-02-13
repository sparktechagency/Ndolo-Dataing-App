import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import '../../../../controllers/auth_controller.dart';
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
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.changePassword.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Old password';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return "Please set new password";
                    } else if (value.length < 8 || !_validatePassword(value)) {
                      return "Password: 8 characters min, letters & digits \nrequired";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return "Please re-enter new password";
                    } else if (value != _authController.newPasswordCtrl.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  hintText: AppStrings.confirmPassword.tr,
                ),
                SizedBox(height: 268.h),
                //==========================> Update Password Button <=======================
                Obx(
                  () => CustomButton(
                    loading: _authController.changePassLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _authController.handleChangePassword(
                            _authController.currentPasswordCtrl.text,
                            _authController.newPasswordCtrl.text);
                      }
                    },
                    text: AppStrings.updatePassword.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(value);
  }
}

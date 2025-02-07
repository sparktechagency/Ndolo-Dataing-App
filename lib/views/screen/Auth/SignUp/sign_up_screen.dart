import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_images.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _authController = Get.put(AuthController());
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(AppIcons.appLogo,
                      height: 150.h, width: 166.w),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: CustomText(
                    text: AppStrings.createAccount.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    bottom: 8.h,
                  ),
                ),
                Center(
                  child: CustomText(
                    text: AppStrings.fillTheInformation.tr,
                    fontSize: 16.sp,
                    maxLine: 2,
                  ),
                ),
                SizedBox(height: 16.h),
                //=======================> First Name Field <=====================
                CustomText(
                  text: 'First Name'.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _authController.firstNameCTR,
                  hintText: 'Type first name'.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SvgPicture.asset(AppIcons.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=======================> Last Name Field <=====================
                CustomText(
                  text: 'Last Name'.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _authController.lastNameCTR,
                  hintText: 'Type last name'.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SvgPicture.asset(AppIcons.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=======================> Email Text Field <=====================
                CustomText(
                  text: AppStrings.email.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _authController.emailCTR,
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
                  controller: _authController.passCTR,
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
                SizedBox(height: 16.h),
                //=======================> Agree with <=====================
                _checkboxSection(),
                SizedBox(height: 16.h),
                //=======================> Sign Up Button <=====================
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.toNamed(AppRoutes.completeProfileScreen);
                      }
                    },
                    text: AppStrings.signUp.tr),
                SizedBox(height: 16.h),

                //=======================> Or  <=====================
                Center(
                  child: CustomText(
                    text: 'Or'.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    bottom: 16.h,
                  ),
                ),
                //=======================> Google and Facebook Button <=====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                  width: 1.w, color: AppColors.primaryColor)),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Image.asset(AppImages.googleLogo,
                                width: 32.w, height: 32.h),
                          )),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                  width: 1.w, color: AppColors.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(AppImages.facebookLogo,
                                width: 32.w, height: 32.h),
                          )),
                    ),
                    // Image.asset(AppImages.facebookLogo, width: 32.w, height: 32.h)
                  ],
                ),
                SizedBox(height: 16.h),
                //=======================> Already have an account <=====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppStrings.alreadyHaveAccount.tr,
                      fontSize: 14.sp,
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signIn.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* //==========================> Checkbox Section Widget <=======================
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: AppStrings.agreeWith.tr,
                  fontSize: 14.sp,
                ),
                SizedBox(width: 4.w),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.termsServicesScreen);
                  },
                  child: CustomText(
                    text: AppStrings.termsOfServices.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text: 'and'.tr,
                  fontSize: 14.sp,
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
                  child: CustomText(
                    text: AppStrings.privacyPolicy.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text: 'to read our'.tr,
                  fontSize: 14.sp,
                ),
                SizedBox(width: 4.w),

                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.aboutUsScreen);
                  },
                  child: CustomText(
                    text: AppStrings.aboutUs.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
*/

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
        Text.rich(
          maxLines: 4,
          TextSpan(
            text: 'By creating an account, I accept \nthe ',
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.termsServicesScreen);
                  },
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: 'Privacy Policy\n',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
              ),
             // const TextSpan(text: '\n to learn more '),
              TextSpan(
                text: 'About Us.',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.aboutUsScreen);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

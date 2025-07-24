import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_images.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_page_loading.dart';
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
  bool isCheckedYears = false;

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
                      return "Please enter your first name".tr;
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
                      return "Please enter your last name".tr;
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
                      return "Please enter your email".tr;
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
                      return "Please enter your password".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=======================> Confirm Password Text Field <=====================
                CustomText(
                  text: AppStrings.confirmPassword.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  isPassword: true,
                  controller: _authController.confirmPassCTR,
                  hintText: AppStrings.confirmPassword.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SvgPicture.asset(AppIcons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password".tr;
                    }
                    else if(_authController.passCTR.text != _authController.confirmPassCTR.text){
                      return "Password doesn't match".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=======================> Agree with <=====================
                _checkboxSectionYears(),
                SizedBox(height: 8.h),
                _checkboxSection(),
                SizedBox(height: 16.h),

                //=======================> Sign Up Button <=====================
                CustomButton(
                  loading: _authController.signInLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked && isCheckedYears) {
                          Get.toNamed(AppRoutes.completeProfileScreen);
                        }
                        else {
                          Fluttertoast.showToast(
                              msg: 'Please accept Terms & Conditions and 18 years old'.tr);
                        }
                      }
                    },
                    text: AppStrings.signUp.tr),
                SizedBox(height: 8.h),
                //=======================> Or  <=====================
                Center(
                  child: CustomText(
                    text: 'Or'.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    bottom: 8.h,
                  ),
                ),
                //=======================> Google and Facebook Button <=====================
                _authController.googleLoginLoading.value
                    ? const CustomPageLoading()
                    : Center(
                  child: GestureDetector(
                    onTap: () {
                      _authController.handleGoogleSignIn(context);
                    },
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                width: 1.w, color: AppColors.primaryColor)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.googleLogo, width: 32.w, height: 32.h),
                              SizedBox(width: 12.w),
                              CustomText(
                                text: 'Sign Up With Google'.tr,
                                fontSize: 18.sp,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         if (isChecked && isCheckedYears) {
                //           _authController.handleGoogleSignIn(context);
                //         }
                //         else {
                //           Fluttertoast.showToast(
                //               msg: 'Please accept Terms & Conditions and 18 years old'.tr);
                //         }
                //       },
                //       child: Container(
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(16.r),
                //               border: Border.all(
                //                   width: 1.w, color: AppColors.primaryColor)),
                //           child: Padding(
                //             padding: EdgeInsets.all(8.w),
                //             child: Image.asset(AppImages.googleLogo,
                //                 width: 32.w, height: 32.h),
                //           )),
                //     ),
                    // SizedBox(width: 12.w),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16.r),
                    //           border: Border.all(
                    //               width: 1.w, color: AppColors.primaryColor)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Image.asset(AppImages.facebookLogo,
                    //             width: 32.w, height: 32.h),
                    //       )),
                    // ),
                    // Image.asset(AppImages.facebookLogo, width: 32.w, height: 32.h)
                 // ],
               // ),
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
            text: 'By creating an account, I accept the'.tr,
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: '\nTerms of Service',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.termsServicesScreen);
                  },
              ),
              TextSpan(text: ' & '.tr),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _checkboxSectionYears() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.greyColor,
          value: isCheckedYears,
          onChanged: (bool? value) {
            setState(() {
              isCheckedYears = value ?? false;
            });
          },
          side: BorderSide(
            color: isCheckedYears ? AppColors.primaryColor : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        Text.rich(
          maxLines: 4,
          TextSpan(
            text: 'I confirm that I am 18 years old or older.'.tr,
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

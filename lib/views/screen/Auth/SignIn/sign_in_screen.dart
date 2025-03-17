import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/auth_controller.dart';
import 'package:ndolo_dating/controllers/localization_controller.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LocalizationController localizationController = Get.find<LocalizationController>();
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final List<String> language = ['English', 'French'];
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedLanguage = language[localizationController.selectedIndex];
      });
    });
  }

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
                SizedBox(height: 56.h),
                //===========================> Language Dropdown Button <===================================
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 110.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.fillColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child:DropdownButton<String>(
                        focusColor: Colors.white,
                        value: selectedLanguage ?? language[0],
                        dropdownColor: AppColors.whiteColor,
                        style: TextStyle(
                          color: AppColors.borderColor,
                          fontSize: 14.sp,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        hint: CustomText(
                          text: 'Language'.tr,
                          fontSize: 14.sp,
                          color: AppColors.borderColor,
                        ),
                        icon: SvgPicture.asset(
                          AppIcons.downArrow,
                          color: AppColors.borderColor,
                        ),
                        isExpanded: true,
                        items: language.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CustomText(
                              text: value,
                              fontSize: 14.sp,
                              color: AppColors.borderColor,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            int selectedIndex = language.indexOf(newValue);
                            if (selectedIndex != -1) {
                              Locale newLocale = Locale(
                                AppConstants.languages[selectedIndex].languageCode,
                                AppConstants.languages[selectedIndex].countryCode,
                              );
                              setState(() {
                                localizationController.setLanguage(newLocale);
                                selectedLanguage = language[selectedIndex];
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SvgPicture.asset(AppIcons.appLogo),
                ),
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
                  ),
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
                  controller: _authController.signInEmailCtrl,
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
                  controller: _authController.signInPassCtrl,
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
                //=======================> Remember Me <=====================
                _checkboxSection(),
                SizedBox(height: 16.h),
                //=======================> Sign In Button <=====================
                Obx(() => CustomButton(
                  loading: _authController.signInLoading.value,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (isChecked) {
                        _authController.handleLogIn();
                      } else {
                        Fluttertoast.showToast(msg: 'Please remember me'.tr);
                      }
                    }
                  },
                  text: AppStrings.signIn.tr,
                )),
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
               /* Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                width: 1.w, color: AppColors.primaryColor)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.googleLogo, width: 32.w, height: 32.h),
                              SizedBox(width: 12.w),
                              CustomText(
                                text: 'Sign in With Google'.tr,
                                fontSize: 18.sp,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),*/
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
                        Get.toNamed(AppRoutes.signUpScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signUp.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
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
          fontSize: 12.sp,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.forgotPasswordScreen);
          },
          child: CustomText(
            text: AppStrings.forgot_Password.tr,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            maxLine: 2,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

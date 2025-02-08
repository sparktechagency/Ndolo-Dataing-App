import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/views/base/custom_pin_code_text_field.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var parameters = Get.parameters;
  final AuthController _authController = Get.put(AuthController());
  int _start = 150;
  Timer _timer = Timer(const Duration(seconds: 1), () {});

  startTimer() {
    print("Start Time$_start");
    print("Start Time$_timer");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isResetPassword = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    if (Get.arguments != null && Get.arguments['isPassreset'] != null) {
      getResetPass();
    }
  }

  getResetPass() {
    var isResetPass = Get.arguments['isPassreset'];
    if (isResetPass) {
      isResetPassword = isResetPass;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
              CustomPinCodeTextField(
                textEditingController: _authController.otpCtrl,
              ),
              SizedBox(height: 16.h),
              Center(
                child: CustomText(
                  text: '$timerText sc',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              /*Center(
                  child: CustomText(
                text: AppStrings.didnotReceiveCode.tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              )),*/
              //======================> Didn’t receive code Section <===================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppStrings.didnotReceiveCode.tr,
                    fontSize: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  //======================> Resend Code Button <===================
                  GestureDetector(
                    onTap: () {
                      _authController.resendOtp("${parameters["email"]}");
                      _authController.otpCtrl.clear();
                    },
                    child: CustomText(
                      text: AppStrings.resendCode.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 132.h),
              //=======================> Verify Button <=====================
              Obx(
                () => CustomButton(
                    loading: _authController.verifyLoading.value,
                    onTap: () {
                      _authController.handleOtpVery(
                          email: "${parameters["email"]}",
                          otp: _authController.otpCtrl.text,
                          type: "${parameters["screenType"]}");
                    },
                    text: AppStrings.verify.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

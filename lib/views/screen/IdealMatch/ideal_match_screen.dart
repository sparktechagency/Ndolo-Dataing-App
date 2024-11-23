import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class IdealMatchScreen extends StatefulWidget {
  const IdealMatchScreen({super.key});

  @override
  State<IdealMatchScreen> createState() => _IdealMatchScreenState();
}

class _IdealMatchScreenState extends State<IdealMatchScreen> {
  String selectedOption = AppStrings.love.tr;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.idealMatch.tr,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff430750),
                ),
                SizedBox(height: 16.h),
                //=======================> PageView Section with Cards <============================
                _roleOption(
                  title: AppStrings.love.tr,
                  description: AppStrings.livenToHaveOne.tr,
                  icon: SvgPicture.asset(AppIcons.love),
                  option: 'Love',
                ),
                _roleOption(
                  title: AppStrings.comeWeStay.tr,
                  description: AppStrings.livenToHelp.tr,
                  icon: SvgPicture.asset(AppIcons.come),
                  option: 'Come-We-Stay',
                ),
                _roleOption(
                  title: AppStrings.imFreeToday.tr,
                  description: AppStrings.casualOrReady.tr,
                  icon: SvgPicture.asset(AppIcons.today),
                  option: 'I\'m Free Today',
                ),
                _roleOption(
                  title: AppStrings.friends.tr,
                  description: AppStrings.iWantToMeet.tr,
                  icon: SvgPicture.asset(AppIcons.friends),
                  option: 'Friends',
                ),
                _roleOption(
                  title: AppStrings.business.tr,
                  description: AppStrings.meetBusinessOriented.tr,
                  icon: SvgPicture.asset(AppIcons.business),
                  option: 'Business',
                ),
                SizedBox(height: 58.h),
                //========================> Continue Button <===============================
                CustomButton(
                    onTap: () {
                       Get.toNamed(AppRoutes.homeScreen);
                    },
                    text: 'Continue'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //========================> Role Option <===============================
  _roleOption({
    required String title,
    required String description,
    required Widget icon,
    required String option,
  }) {
    bool isSelected = selectedOption == option;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.secondaryColor
                            : Colors.black,
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_box_rounded,
                          color: Color(0xff8DB501),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: description,
                    fontSize: 16.sp,
                    color: Colors.grey.shade700,
                    maxLine: 2,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

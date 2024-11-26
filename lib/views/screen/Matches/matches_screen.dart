import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_images.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

import '../../base/bottom_menu..dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(1),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.matches.tr,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.woman,
                    width: 112.w,
                    height: 133.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Fozia Islam',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff430750),
                          ),
                          SvgPicture.asset(
                            AppIcons.like,
                            color: AppColors.primaryColor,
                            width: 28.w,
                            height: 28.h,
                          )
                        ],
                      ),
                      CustomText(
                        text: '24 years',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(AppIcons.location,
                              color: AppColors.primaryColor,
                              width: 12.w,
                              height: 12.h),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: 'USA',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff430750),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                          width: 165.w,
                          child: CustomButton(
                              onTap: () {}, text: AppStrings.sendMessage.tr)),
                      SizedBox(height: 8.h),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

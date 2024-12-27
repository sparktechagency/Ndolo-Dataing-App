import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_text.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.notifications.tr),
      //================================> Body section <=======================
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            //================================> Notification section <=======================
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 16.h, top: index == 0 ? 16 .h : 0),
                    child: _Notification(
                      'Your profile is matched with Jane Cooper!',
                      DateTime.now(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  _Notification(
      String title,
      DateTime time,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  //==============================> Notification Icon <=========================
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.all(7.w),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffFDE0EE)),
                    child: SvgPicture.asset(
                      AppIcons.notification,
                      width: 32.w,
                      height: 32.h,
                      color: AppColors.primaryColor
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //==============================> Notification Text <=========================
                    CustomText(
                      text: title,
                      fontSize: 14.h,
                      maxLine: 3,
                      textAlign: TextAlign.start,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        top: 2.h,
                        text: TimeAgo.format(time),
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF8C8C8C,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: AppColors.textColor),
        ],
      ),
    );
  }
}

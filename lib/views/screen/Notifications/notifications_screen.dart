import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/notification_controller.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_text.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationController _controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    _controller.getNotificationData();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.notifications.tr),
      //================================> Body section <=======================
      body: Obx(() {
        if (_controller.notificationLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        else if (_controller.notificationModel.isEmpty) {
          return Center(child: CustomText(text: "Notification is empty".tr));
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              //================================> Notification section <=======================
              Expanded(
                child: ListView.builder(
                  itemCount: _controller.notificationModel.length,
                  itemBuilder: (context, index) {
                    var data = _controller.notificationModel[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 16.h, top: index == 0 ? 16.h : 0),
                      child: _Notification(
                        '${data.title}',
                        DateTime.parse('${data.createdAt}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
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
                    child: SvgPicture.asset(AppIcons.notification,
                        width: 32.w,
                        height: 32.h,
                        color: AppColors.primaryColor),
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

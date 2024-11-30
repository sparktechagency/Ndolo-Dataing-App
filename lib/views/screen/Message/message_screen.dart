import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(2),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.message.tr,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.chatScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            //=====================> Image <=======================
                            CustomNetworkImage(
                              imageUrl:
                                  'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GwEsZ3WRA~UZBXPSyVn1~EP56OutWf9ks3Pp5SGI6MCjGGZAFlHEi2N4IlDVFviedcItZdtfZQtgWJHPudEZFWEcFDRzdXKF-VR8B1Sbr0xTBOs2pmjcEAJUy-mGNPoh0~QXEtajPrE9MKTiQrV2581Cm0gx8yNzIXLqrRy5xdqs6nyUprsgffdi~rkm3SylakKm40tW6mCca7fwwTduZ6hzxrjf1vsbiFdkl9ntcgMN89j3zasCaMxVOa9wueLCPiablbJiC1z5lO8nY5ensKpTa5AKMLg0pS6dIDBEst9u95IIhxLBaaheZC2JrOb6aAwBzMY2hq5R1IhXkaWpfg__',
                              height: 45.h,
                              width: 45.w,
                              boxShape: BoxShape.circle,
                            ),
                            //=====================> Active Green Icon <=======================
                            Positioned(
                              right: 0.w,
                              bottom: 4.h,
                              child: Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 10.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //=====================> Name <=======================
                              CustomText(
                                text: 'Rida Anam',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                bottom: 6.h,
                                maxLine: 2,
                                textAlign: TextAlign.start,
                              ),
                              //=====================> Last Message <=======================
                              CustomText(
                                text: 'Hello, are you here?',
                                fontWeight: FontWeight.w500,
                                maxLine: 2,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

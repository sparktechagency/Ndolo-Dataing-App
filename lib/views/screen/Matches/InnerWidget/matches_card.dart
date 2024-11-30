import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';

class MatchesCard extends StatelessWidget {
  const MatchesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    //====================> Image <==========================
                    CustomNetworkImage(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GwEsZ3WRA~UZBXPSyVn1~EP56OutWf9ks3Pp5SGI6MCjGGZAFlHEi2N4IlDVFviedcItZdtfZQtgWJHPudEZFWEcFDRzdXKF-VR8B1Sbr0xTBOs2pmjcEAJUy-mGNPoh0~QXEtajPrE9MKTiQrV2581Cm0gx8yNzIXLqrRy5xdqs6nyUprsgffdi~rkm3SylakKm40tW6mCca7fwwTduZ6hzxrjf1vsbiFdkl9ntcgMN89j3zasCaMxVOa9wueLCPiablbJiC1z5lO8nY5ensKpTa5AKMLg0pS6dIDBEst9u95IIhxLBaaheZC2JrOb6aAwBzMY2hq5R1IhXkaWpfg__',
                      height: 145.h,
                      width: 112.w,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          bottomLeft: Radius.circular(8.r)),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //====================> Name and Year <==========================
                        CustomText(
                          text: 'Fouzia Islam',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff430750),
                        ),
                        CustomText(text: '24 years'),
                        //====================> Location Row <===========================
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
                              color: const Color(0xff430750),
                            ),
                          ],
                        ),
                        //====================> Send Message Button <===========================
                        SizedBox(height: 16.h),
                        SizedBox(
                            width: 165.w,
                            child: CustomButton(
                                onTap: () {
                                  Get.toNamed(AppRoutes.profileDetailsScreen);
                                },
                                text: AppStrings.sendMessage.tr)),
                        SizedBox(height: 8.h),
                      ],
                    )
                  ],
                ),
              ),
              //====================> Love Button <===========================
              Positioned(
                right: 10.w,
                top: 5.h,
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.like,
                    color: AppColors.primaryColor,
                    width: 28.w,
                    height: 28.h,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

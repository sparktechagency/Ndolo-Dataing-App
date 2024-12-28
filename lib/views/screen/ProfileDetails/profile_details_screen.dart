import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========================> Image Container <==========================
              CustomNetworkImage(
                imageUrl:
                    'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HP~g2isaLmKYYEX7JW5pkf3BqASThNhk2qr9Lwm4n~hb3-MNOCkMkSKisOmJR1Ek1RbvHPJg0FR0JQMftfttFmCtbeAzM92m1pgnyTco2JJSLsO5FRaNeULov3LA1cjRd1PhnJptohNDdsWFaR2MD8KnrfxfxKZ3svY5SPrGvRQZVLJ44z0tGYwRxkd8PvJP0TTUdQZNodflp7pIQQZN3oVyanZ~68VCaFlQc6j8jzOSFYeYpSPk6CSs2R61QZhvdCJ1Ys1re~sL5TUgZmDIeBobPPnuYe~u36UYZf8yl4JRCfJO50xNVW7mD9Twq3HtYS8RHCqjoAYHrwt3Sbf8mg__',
                height: 500.h,
                width: double.infinity,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r)),
              ),
              //========================> Name and Location Container <==========================
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardLightColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    children: [
                      //==================> Name Row <==================
                      Row(
                        children: [
                          CustomText(
                            text: 'Janet Doe',
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff430750),
                          ),
                          SizedBox(width: 8.w),
                          CustomText(
                            text: '19',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff430750),
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.chatScreen);
                              },
                              child: SvgPicture.asset(
                                AppIcons.messageOut,
                                color: const Color(0xff430750),
                              ))
                        ],
                      ),
                      SizedBox(height: 8.h),
                      //==================> Location Row <==================
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.location,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8.w),
                          CustomText(
                            text: 'USA',
                            fontSize: 18.sp,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              //========================> About Container <==========================
              CustomText(
                text: AppStrings.bio.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                bottom: 4.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardLightColor,
                  borderRadius: BorderRadius.circular((8.r)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    children: [
                      //==================> Name Row <==================
                      CustomText(
                        text:
                            'Hello there! I\'m Rida, seeking a lifelong adventure partner. A blend of tradition and modernity, I find joy in the simple moments and cherish family values. With a heart that believes in love\'s magic, I\'m looking for someone to share happiness.',
                        fontSize: 14.sp,
                        maxLine: 15,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              //========================> Interest Section <==========================
              CustomText(
                text: AppStrings.interest.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _interestChip(SvgPicture.asset(AppIcons.movie), 'Movie'),
                  _interestChip(SvgPicture.asset(AppIcons.movie), 'Snooker'),
                  _interestChip(
                      SvgPicture.asset(AppIcons.swimming), 'Swimming'),
                  _interestChip(
                      SvgPicture.asset(AppIcons.book), 'Books Reading'),
                  _interestChip(
                      SvgPicture.asset(AppIcons.photo), 'Photography'),
                  _interestChip(SvgPicture.asset(AppIcons.design), 'Design'),
                  _interestChip(SvgPicture.asset(AppIcons.music), 'Music'),
                  _interestChip(SvgPicture.asset(AppIcons.cooking), 'Cooking'),
                ],
              ),
              SizedBox(height: 16.h),
              //========================> Gallery Section <==========================
              CustomText(
                text: AppStrings.gallery.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return CustomNetworkImage(
                    imageUrl:
                        'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GwEsZ3WRA~UZBXPSyVn1~EP56OutWf9ks3Pp5SGI6MCjGGZAFlHEi2N4IlDVFviedcItZdtfZQtgWJHPudEZFWEcFDRzdXKF-VR8B1Sbr0xTBOs2pmjcEAJUy-mGNPoh0~QXEtajPrE9MKTiQrV2581Cm0gx8yNzIXLqrRy5xdqs6nyUprsgffdi~rkm3SylakKm40tW6mCca7fwwTduZ6hzxrjf1vsbiFdkl9ntcgMN89j3zasCaMxVOa9wueLCPiablbJiC1z5lO8nY5ensKpTa5AKMLg0pS6dIDBEst9u95IIhxLBaaheZC2JrOb6aAwBzMY2hq5R1IhXkaWpfg__',
                    height: 75.h,
                    width: 70.w,
                    borderRadius: BorderRadius.circular(4.r),
                  );
                }),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

//======================================> Interest Chip <========================
  _interestChip(Widget icon, String label) {
    return Chip(
      side: BorderSide(width: 1.w, color: const Color(0xff430750)),
      label: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: 8.w),
            CustomText(
              text: label,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}

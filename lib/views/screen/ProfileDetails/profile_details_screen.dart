import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/home_controller.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});
  final HomeController _homeController = Get.put(HomeController());
  var parameter = Get.parameters;

  @override
  Widget build(BuildContext context) {
    _homeController.getSingleUserData(parameter['_id']!);
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails),
      body: Obx(
        () => _homeController.homeLoading.value
          ? const Center(child: CustomPageLoading(),)
        : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //========================> Image Container <==========================
                CustomNetworkImage(
                  imageUrl:
                      '${ApiConstants.imageBaseUrl}${_homeController.singleUserModel.value.profileImage}',
                  height: 400.h,
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
                            Flexible(
                              child: CustomText(
                                text: '${_homeController.singleUserModel.value.fullName}',
                                fontSize: 30.sp,
                                maxLine: 3,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff430750),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: '${Get.parameters['age']}',
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
                              text:
                                  '${_homeController.singleUserModel.value.country}',
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
                          text: '${_homeController.singleUserModel.value.bio}',
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
               /* Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(_homeController.singleUserModel.value.interests!.length, (index) {
                    return _interestChip(
                      SvgPicture.asset(_homeController.singleUserModel.value.interests?.length['icon']),
                      _homeController.singleUserModel.value.interests?.length[index]['label'],
                    );
                  }),
                ),*/
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
                  children: List.generate(
                      _homeController.singleUserModel.value.gallery!.length,
                      (index) {
                    return CustomNetworkImage(
                      imageUrl:
                          '${_homeController.singleUserModel.value.gallery}',
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

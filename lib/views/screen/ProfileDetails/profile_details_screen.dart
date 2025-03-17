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

import '../../../controllers/messages/message_controller.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final MessageController controller = Get.put(MessageController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (parameter['profileId'] != null) {
        _homeController.getSingleUserData(parameter['profileId']!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails.tr),
      body: Obx(() {
        if (_homeController.singleLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        final user = _homeController.singleUserModel.value;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //========================> Image Container <==========================
                CustomNetworkImage(
                  imageUrl:
                      '${ApiConstants.imageBaseUrl}${user.gallery?[0] ?? ""}',
                  height: 400.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                //========================> Name and Location Container <==========================
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardLightColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: CustomText(
                                text: user.fullName ?? "N/A",
                                fontSize: 30.sp,
                                maxLine: 3,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff430750),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: parameter['age'] ?? "N/A",
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff430750),
                            ),
                      /*      const Spacer(),
                            InkWell(
                              onTap: () {
                                controller.createConversation(parameter['_id']!);
                              },
                              child: SvgPicture.asset(
                                AppIcons.messageOut,
                                color: const Color(0xff430750),
                              ),
                            ),*/
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.location,
                              color: Colors.black,
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: user.address ?? "N/A",
                              fontSize: 18.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.bio.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  bottom: 4.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardLightColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: CustomText(
                      text: user.bio ?? "No bio available",
                      fontSize: 14.sp,
                      maxLine: 15,
                      textAlign: TextAlign.start,
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
                  children: List.generate(
                    user.interests?.length ?? 0,
                    (index) {
                      final interest = user.interests![index];
                      return _interestChip(
                        CustomNetworkImage(
                            imageUrl: '${ApiConstants.imageBaseUrl}${interest.icon ?? ""}',
                            height: 24.h,
                            width: 24.w,
                        boxShape: BoxShape.circle
                        ),
                        interest.name?.capitalize ?? "N/A", // Null check for label
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                //========================> Gallery Section <==========================
                CustomText(
                  text: AppStrings.gallery.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 8.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      user.gallery?.length ?? 0,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: CustomNetworkImage(
                            imageUrl:
                                '${ApiConstants.imageBaseUrl}${user.gallery![index] ?? ""}',
                            height: 75.h,
                            width: 70.w,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  //======================================> Interest Chip <========================
  _interestChip(Widget icon, String label) {
    return Chip(
      side: BorderSide(width: 1.w, color: const Color(0xff430750)),
      label: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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

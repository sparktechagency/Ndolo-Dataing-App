import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/profile_controller.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/views/base/custom_list_tile.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_button.dart';
import '../../base/custom_profile_image.dart';
import '../../base/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    _profileController.getProfileData();
    return Scaffold(
      bottomNavigationBar: const BottomMenu(3),
      //=============================> AppBar Section <=============================
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
            InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.settingsScreen);
                },
                child: SvgPicture.asset(AppIcons.settings,
                    width: 32.w, height: 32.h))
          ],
        ),
      ),
      //=============================> Body Section <=============================
      body: Obx(
        () => _profileController.profileLoading.value
            ? const Center(child: CustomPageLoading())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(children: [
                          //=============================> Profile And Cover Picture <=============================
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              //=========================> Cover Picture <=======================
                              CustomNetworkImage(
                                imageUrl:
                                    '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.coverImage}',
                                height: 135.h,
                                width: 345.w,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              Positioned(
                                bottom: -70.h,
                                left: 50.w,
                                right: 50.w,
                                //==========================> Profile Picture <=======================
                                child: CustomProfileImage(
                                  imageUrl:
                                      '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.profileImage}',
                                  height: 144.h,
                                  width: 144.w,
                                  boxShape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2.w,
                                      color: AppColors.primaryColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 98.h),
                          //=============================> Update Pictures Button <=============================
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.uploadPhotosScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 12.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(AppIcons.pen),
                                    SizedBox(width: 8.w),
                                    CustomText(
                                      text: AppStrings.updatePictures.tr,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          //=============================> Name Section <=============================
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: CustomText(
                              text:
                                  '${_profileController.profileModel.value.fullName}',
                              fontWeight: FontWeight.w700,
                              fontSize: 30.sp,
                              maxLine: 5,
                              color: const Color(0xff430750),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Column(
                      children: [
                        //=====================> Account Information List Tile <===================
                        CustomListTile(
                          onTap: () {
                            Get.toNamed(AppRoutes.accountInformationScreen);
                          },
                          title: AppStrings.accountInformation.tr,
                          prefixIcon: SvgPicture.asset(AppIcons.account),
                          suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                        ),
                        //=====================> Log Out List Tile <===================
                        CustomListTile(
                          onTap: () {
                            _showCustomBottomSheet(context);
                          },
                          title: AppStrings.logOut.tr,
                          prefixIcon: SvgPicture.asset(AppIcons.logOut),
                          suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  //===============================> Log Out Bottom Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: AppColors.cardColor,
          ),
          height: 265.h,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: AppStrings.logOut.tr,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: Colors.red,
              ),
              SizedBox(height: 20.h),
              Divider(
                thickness: 1,
                color: AppColors.primaryColor,
                indent: 15.w,
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: AppStrings.areYouSureToLogOut.tr,
                maxLine: 3,
                fontSize: 16.sp,
              ),
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 115.w,
                      child: CustomButton(
                        onTap: () {
                          Get.back();
                        },
                        text: "No",
                        color: Colors.white,
                        textColor: AppColors.primaryColor,
                      )),
                  SizedBox(width: 16.w),
                  SizedBox(
                      width: 115.w,
                      child: CustomButton(
                          onTap: () async {
                            await PrefsHelper.remove(AppConstants.isLogged);
                            await PrefsHelper.remove(AppConstants.userId);
                            await PrefsHelper.remove(AppConstants.bearerToken);
                            await PrefsHelper.remove(AppConstants.hasUpdateGallery);
                            Get.offAllNamed(AppRoutes.signInScreen);
                          },
                          text: "Yes")),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

//================================> Popup Menu Button Method <=============================
  PopupMenuButton<int> _popupMenuButton() {
    return PopupMenuButton<int>(
      //  icon: const Icon(Icons.more_vert),
      onSelected: (int result) {
        if (result == 0) {
          print('French');
        } else if (result == 1) {
          print('English');
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              const Icon(Icons.report, color: Colors.black54),
              SizedBox(width: 10.w),
              const Text(
                'French',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              const Icon(Icons.block, color: Colors.black54),
              SizedBox(width: 10.w),
              const Text(
                'English',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

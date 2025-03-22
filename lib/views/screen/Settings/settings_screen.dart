import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_alart.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_list_tile.dart';
import '../../../controllers/localization_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final TextEditingController _passCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.settings.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              //=====================> Change Password List Tile <===================
              CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.changePasswordScreen);
                },
                title: AppStrings.changePassword.tr,
                prefixIcon: SvgPicture.asset(AppIcons.change),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Set a distance  List Tile <===================
              CustomListTile(
                onTap: () {Get.toNamed(AppRoutes.setDistanceScreen);},
                title: AppStrings.setDistance.tr,
                prefixIcon: SvgPicture.asset(AppIcons.location),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Language List Tile <===================
              CustomListTile(
                onTap: () {
                  _languageBottomSheet(context);
                },
                title: AppStrings.language.tr,
                prefixIcon: SvgPicture.asset(AppIcons.lan),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Privacy Policy  List Tile <===================
             /* CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicyScreen);
                },
                title: AppStrings.privacyPolicy.tr,
                prefixIcon: SvgPicture.asset(AppIcons.privacy),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Terms of Services List Tile <===================
              CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.termsServicesScreen);
                },
                title: AppStrings.termsOfServices.tr,
                prefixIcon: SvgPicture.asset(AppIcons.terms),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> About Us List Tile <===================
              CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.aboutUsScreen);
                },
                title: AppStrings.aboutUs.tr,
                prefixIcon: SvgPicture.asset(AppIcons.about),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
*/
              //=====================> Delete Account List Tile <===================
              CustomListTile(
                onTap: () {
                  _showCustomBottomSheet(context);
                },
                title: AppStrings.deleteAccount.tr,
                prefixIcon: SvgPicture.asset(AppIcons.delete),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //===============================> Delete Account Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 423.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
            color: AppColors.whiteColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(16.r)),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: CustomText(
                  text: AppStrings.enterYourPasswordToDeleteAccount.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  maxLine: 5,
                ),
              ),
              SizedBox(height: 32.h),
              //===============================> Place Bid  <====================
              CustomText(
                text: AppStrings.currentPassword.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                bottom: 14.h,
              ),
              CustomTextField(
                controller: _passCTRL,
                hintText: 'Enter your password',
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SvgPicture.asset(AppIcons.email,
                      color: AppColors.borderColor, width: 18.w, height: 18.h),
                ),
              ),
              SizedBox(height: 24.h),
              //===============================> Delete Account Button <====================
              CustomButton(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const CustomAlert();
                      });
                },
                text: 'Delete Account'.tr,
              ),
            ],
          ),
        );
      },
    );
  }

  //===============================> Language Bottom Sheet <===============================
  _languageBottomSheet(BuildContext context) {
    final LocalizationController localizationController = Get.find<LocalizationController>();

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
          height: 265,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: AppStrings.language.tr,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 20.h),
              Divider(
                thickness: 1,
                color: AppColors.primaryColor,
                indent: 15.w,
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: AppStrings.chooseYourLanguage.tr,
                maxLine: 2,
                fontSize: 16.sp,
              ),
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 120.w,
                    onTap: () {
                      localizationController.setLanguage(const Locale('fr', 'FR'));
                      if (kDebugMode) {
                        print('==============> Select French Language');
                      }
                      Get.back();
                    },
                    text: "French",
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                      width: 120.w,
                      onTap: () {
                        localizationController.setLanguage(const Locale('en', 'US'));
                        if (kDebugMode) {
                          print('==============> Select English Language');
                        }
                        Get.back();
                      },
                      text: "English"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

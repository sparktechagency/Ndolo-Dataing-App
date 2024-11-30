import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/profile_controller.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class EditAccountInformation extends StatelessWidget {
  EditAccountInformation({super.key});
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.editAccountInformation.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //======================> Name Text Field <========================
              CustomText(
                text: AppStrings.name.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                controller: _profileController.nameCTRL,
                hintText: 'Janet Doe',
              ),
              SizedBox(height: 16.h),
              //======================> Date of Birth Text Field <========================
              CustomText(
                text: AppStrings.dateOfBirth.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                onTab: () {
                  _profileController.pickBirthDate(context);
                },
                readOnly: true,
                controller: _profileController.dateBirthCTRL,
                hintText: '16 AUG 2000',
                suffixIcons: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SvgPicture.asset(AppIcons.calenderIcon),
                ),
              ),
              SizedBox(height: 16.h),
              //======================> Location Text Field <========================
              CustomText(
                text: AppStrings.location.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                controller: _profileController.locationCTRL,
                hintText: '6391 Elgin St. Celina, Delaware 10299',
              ),
              SizedBox(height: 16.h),
              //======================> Bio Text Field <========================
              CustomText(
                text: AppStrings.bio.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                controller: _profileController.bioCTRL,
                hintText:
                    'Lorem ipsum dolor sit amet consectetur. Proin id massa consectetur magna urna. Sed sed curabitur est congue nulla habitant egestas. Interdum et sed viverra adipiscing. Mi venenatis habitant tincidunt id integer sed vitae.',
                maxLines: 5,
              ),
              SizedBox(height: 16.h),
              //======================> Eating Practice Text Field <========================
              CustomText(
                text: AppStrings.eatingPractice.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                controller: _profileController.eatingCTRL,
                hintText:
                    'Lorem ipsum dolor sit amet consectetur. Proin id massa consectetur magna urna. Sed sed curabitur est congue nulla habitant egestas. Interdum et sed viverra adipiscing. Mi venenatis habitant tincidunt id integer sed vitae.',
                maxLines: 5,
              ),
              SizedBox(height: 16.h),
              //======================> Favorite Cuisine Text Field <========================
              CustomText(
                text: AppStrings.favoriteCuisine.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomTextField(
                controller: _profileController.favoriteCTRL,
                hintText:
                    'Lorem ipsum dolor sit amet consectetur. Prion id mass consectetur magna urn. Sed sed curability est tongue nulla habitant egestas. Interdum et sed viverra adipiscing. Mi venenatis habitant tincidunt id integer sed vitae.',
                maxLines: 5,
              ),
              SizedBox(height: 32.h),
              //======================> Update Button <========================
              CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  text: 'Update'.tr),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

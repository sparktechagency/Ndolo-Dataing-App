import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_list_tile.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.accountInformation.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //======================> Name List Tile <========================
              CustomText(
                text: AppStrings.name.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'Janet Doe'),
              SizedBox(height: 16.h),
              //======================> Email List Tile <========================
              CustomText(
                text: AppStrings.email.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'abc@gmail.com'),
              SizedBox(height: 16.h),
              //======================> Date Of Birth List Tile <========================
              CustomText(
                text: AppStrings.dateOfBirth.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: '16 AUG 2000'),
              SizedBox(height: 16.h),
              //======================> Location List Tile <========================
              CustomText(
                text: AppStrings.location.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: '6391 Elgin St. Celina, Delaware 10299'),
              SizedBox(height: 16.h),
              //======================> Bio List Tile <========================
              CustomText(
                text: AppStrings.bio.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(
                  title:
                      'Hello there! I\'m Rida, seeking a lifelong adventure partner. A blend of tradition and modernity, I find joy in the simple moments and cherish family values. With a heart that believes in love\'s magic, I\'m looking for someone to share happiness.'),
              SizedBox(height: 16.h),
              //======================> Eating Practice List Tile <========================
              CustomText(
                text: AppStrings.eatingPractice.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(
                  title:
                      'Lorem ipsum dolor sit amet consectetur. Protein id mass consectetur magna urn. Sed sed curability est tongue null habitat gestates. Interdict et sed riviera adipiscing. Mi venation habitat incident id integer sed vitae.'),
              SizedBox(height: 16.h),
              //======================> Favorite Cuisine List Tile <========================
              CustomText(
                text: AppStrings.favoriteCuisine.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(
                  title:
                      'Lorem ipsum dolor sit amet consectetur. Cras quam ut turpis lorem fermentum diam integer. Elementum in purus ut nunc hendrerit eget. Sed sem ullamcorper sed nunc orci tempor purus vel. Netus elementum accumsan et nunc tellus quis.'),
              SizedBox(height: 32.h),
              //======================> Edit Button <========================
              CustomButton(onTap: () {}, text: AppStrings.edit.tr),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_list_tile.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

import '../../../controllers/profile_controller.dart';

class AccountInformationScreen extends StatelessWidget {
   AccountInformationScreen({super.key});
  final ProfileController _profileController = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    _profileController.getProfileData();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.accountInformation.tr),
      body:  SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //======================> First Name List Tile <========================
                CustomText(
                  text: AppStrings.firstName.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.firstName}'),
                SizedBox(height: 16.h),
                //======================> Last Name List Tile <========================
                CustomText(
                  text: AppStrings.lastName.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.lastName}'),
                SizedBox(height: 16.h),
                //======================> Email List Tile <========================
                CustomText(
                  text: AppStrings.email.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.email}'),
                SizedBox(height: 16.h),
                //======================> Phone Number List Tile <========================
                CustomText(
                  text: AppStrings.phoneNumber.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.callingCode}${_profileController.profileModel.value.phoneNumber}'),
                SizedBox(height: 16.h),
                //======================> Date Of Birth List Tile <========================
                CustomText(
                  text: AppStrings.dateOfBirth.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: DateFormat('yyyy-MM-dd').format(DateTime.parse('${_profileController.profileModel.value.dateOfBirth}'))),
                SizedBox(height: 16.h),
                //======================> Country List Tile <========================
                CustomText(
                  text: AppStrings.country.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.country}'),
                SizedBox(height: 16.h),
                //======================> State List Tile <========================
                CustomText(
                  text: AppStrings.state.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.state}'),
                SizedBox(height: 16.h),
                //======================> City List Tile <========================
                CustomText(
                  text: AppStrings.city.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.city}'),
                SizedBox(height: 16.h),
                //======================> address List Tile <========================
                CustomText(
                  text: AppStrings.address.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(title: '${_profileController.profileModel.value.address}'),
                SizedBox(height: 16.h),
                //======================> Bio List Tile <========================
                CustomText(
                  text: AppStrings.bio.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomListTile(
                    title: '${_profileController.profileModel.value.bio}'),
                SizedBox(height: 32.h),
                //======================> Edit Button <========================
                CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.editAccountInformation, parameters: {
                        'firstName': '${_profileController.profileModel.value.firstName}' ?? '',
                        'lastName': '${_profileController.profileModel.value.lastName}' ?? '',
                        'phoneNumber': '${_profileController.profileModel.value.phoneNumber}' ?? '',
                        'dateOfBirth': '${_profileController.profileModel.value.dateOfBirth}' ?? '',
                        'country': '${_profileController.profileModel.value.country}' ?? '',
                        'state': '${_profileController.profileModel.value.state}' ?? '',
                        'city': '${_profileController.profileModel.value.city}' ?? '',
                        'address': '${_profileController.profileModel.value.address}' ?? '',
                        'bio': '${_profileController.profileModel.value.bio}' ?? '',
                      });
                    },
                    text: AppStrings.edit.tr),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),

    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_list_tile.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

import '../../../controllers/profile_controller.dart';

class AccountInformationScreen extends StatefulWidget {
  AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() => _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    // Ensure API call happens after widget build completes
    Future.delayed(Duration(milliseconds: 100), () {
      _profileController.getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.accountInformation.tr),
      body: Obx(() {
        if (_profileController.profileLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        if (_profileController.profileModel.value.id == null) {
          return const Center(child: Text("Failed to load data data."));
        }
        var data = _profileController.profileModel.value;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileDetail(AppStrings.firstName.tr, data.firstName),
              _profileDetail(AppStrings.lastName.tr, data.lastName),
              _profileDetail(AppStrings.email.tr, data.email),
              _profileDetail(AppStrings.phoneNumber.tr, "${data.callingCode ?? ''} ${data.phoneNumber ?? ''}"),
              _profileDetail(AppStrings.dateOfBirth.tr, DateFormat('yyyy-MM-dd').format(DateTime.parse('${data.dateOfBirth}' ?? ''))),
              _profileDetail(AppStrings.country.tr, data.country),
              _profileDetail(AppStrings.state.tr, data.state),
              _profileDetail(AppStrings.city.tr, data.city),
              _profileDetail(AppStrings.address.tr, data.address),
              _profileDetail(AppStrings.bio.tr, data.bio),

              SizedBox(height: 32.h),

              //======================> Edit Button <========================
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.editAccountInformation, parameters: {
                    'firstName': data.firstName ?? '',
                    'lastName': data.lastName ?? '',
                    'phoneNumber': '${data.phoneNumber}' ?? '',
                    'dateOfBirth': '${data.dateOfBirth}' ?? '',
                    'country': data.country ?? '',
                    'state': data.state ?? '',
                    'city': data.city ?? '',
                    'address': data.address ?? '',
                    'bio': data.bio ?? '',
                  });
                },
                text: AppStrings.edit.tr,
              ),
              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }
//=======================================> Profile Detail <============================
  Widget _profileDetail(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          bottom: 8.h,
        ),
        CustomListTile(title: value ?? "N/A"),
        SizedBox(height: 16.h),
      ],
    );
  }
}

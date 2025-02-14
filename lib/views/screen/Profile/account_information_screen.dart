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
  const AccountInformationScreen({super.key});
  @override
  State<AccountInformationScreen> createState() => _AccountInformationScreenState();
}
class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
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
              SizedBox(height: 16.h),
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
  _profileDetail(String title, String? value) {
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
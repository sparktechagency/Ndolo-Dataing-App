import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ndolo_dating/controllers/profile_controller.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../service/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class EditAccountInformation extends StatefulWidget {
  EditAccountInformation({super.key});

  @override
  State<EditAccountInformation> createState() => _EditAccountInformationState();
}

class _EditAccountInformationState extends State<EditAccountInformation> {
  final ProfileController _profileController = Get.put(ProfileController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    _profileController.firstNameCTRL.text = Get.parameters['firstName'] ?? '';
    _profileController.lastNameCTRL.text = Get.parameters['lastName'] ?? '';
    _profileController.phoneNumberCTRL.text = Get.parameters['phoneNumber'] ?? '';
    _profileController.dateBirthCTRL.text = Get.parameters['dateOfBirth'] ?? '';
    _profileController.countryCTRL.text = Get.parameters['country'] ?? '';
    _profileController.stateCTRL.text = Get.parameters['state'] ?? '';
    _profileController.cityCTRL.text = Get.parameters['city'] ?? '';
    _profileController.addressCTRL.text = Get.parameters['address'] ?? '';
    _profileController.bioCTRL.text = Get.parameters['bio'] ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.editAccountInformation.tr),
      body: Obx(()=> SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //======================> Profile Image <========================
                CustomText(
                  text: AppStrings.profileImage.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _profileController.profileImagePath.value.isNotEmpty
                          ? Container(
                        width: 134.w,
                        height: 134.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(File(_profileController
                                    .profileImagePath.value)),
                                fit: BoxFit.cover)),
                      )
                          : CustomNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}${Get.parameters['image']}',
                        width: 134.w,
                        height: 134.h,
                        boxShape: BoxShape.circle,
                      ),
                      Positioned(
                        bottom: 8.h,
                        right: 8.w,
                        child: GestureDetector(
                          onTap: () {
                            print('========> Tapped');
                            _showImagePickerOption(isProfileImage: true);
                          },
                          child: SvgPicture.asset(AppIcons.edit),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                //======================> Cover Image <========================
                CustomText(
                  text: AppStrings.coverImage.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _profileController.coverImagePath.value.isNotEmpty
                          ? Container(
                        width: 345.w,
                        height: 134.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                                image: FileImage(File(_profileController
                                    .coverImagePath.value)),
                                fit: BoxFit.cover)),
                      )
                          : CustomNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}${Get.parameters['image']}',
                        width: 345.w,
                        height: 134.h,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      Positioned(
                        bottom: 8.h,
                        right: 8.w,
                        child: GestureDetector(
                          onTap: () {
                            print('========> Tapped');
                            _showImagePickerOption(isProfileImage: false);
                          },
                          child: SvgPicture.asset(AppIcons.edit),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                //======================> First Name Text Field <========================
                CustomText(
                  text: AppStrings.firstName.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _profileController.firstNameCTRL,
                  hintText: 'Janet',
                ),
                SizedBox(height: 16.h),
                //======================> Last Name Text Field <========================
                CustomText(
                  text: AppStrings.lastName.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _profileController.lastNameCTRL,
                  hintText: 'Doe',
                ),
                SizedBox(height: 16.h),
                //======================> Phone Number Text Field <========================
                CustomText(
                  text: AppStrings.phoneNumber.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                IntlPhoneField(
                  controller: _profileController.phoneNumberCTRL,
                  decoration: InputDecoration(
                    hintText: "Phone number",
                    contentPadding:EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
                    ),
                  ),

                  showCountryFlag: true,
                  initialCountryCode: 'US',
                  flagsButtonMargin: EdgeInsets.only(left: 10.w),
                  disableLengthCheck: true,
                  dropdownIconPosition: IconPosition.trailing,
                  onChanged: (phone) {
                    print("Phone===============> ${phone.completeNumber}");
                  },
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
                //======================> Country Text Field <========================
                CustomText(
                  text: AppStrings.country.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _profileController.countryCTRL,
                  hintText: 'Bangladesh',
                ),
                SizedBox(height: 16.h),
                //======================> State Text Field <========================
                CustomText(
                  text: AppStrings.state.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _profileController.stateCTRL,
                  hintText: 'BD',
                ),
                SizedBox(height: 16.h),
                //======================> City Text Field <========================
                CustomText(
                  text: AppStrings.city.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _profileController.cityCTRL,
                  hintText: 'Dhaka',
                ),
                SizedBox(height: 16.h),
                //======================> Address Text Field <========================
                CustomText(
                  text: AppStrings.address.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _profileController.addressCTRL,
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
               SizedBox(height: 32.h),
                //======================> Update Button <========================
                Obx(()=> CustomButton(
                    loading: _profileController.updateProfileLoading.value,
                      onTap: () {
                       _profileController.updateProfile();
                      },
                      text: 'Update'.tr),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===============================> Show Image Picker Option <=============================
  void _showImagePickerOption({required bool isProfileImage}) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              //=========================> Pick Image from Gallery <==================
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await _profileController.pickImage(ImageSource.gallery, isProfileImage);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image, size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Gallery',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
              //=========================> Pick Image from Camera <====================
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await _profileController.pickImage(ImageSource.camera, isProfileImage);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt, size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Camera',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

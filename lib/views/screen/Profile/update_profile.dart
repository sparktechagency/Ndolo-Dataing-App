import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ndolo_dating/controllers/profile_controller.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../service/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _EditAccountInformationState();
}

class _EditAccountInformationState extends State<UpdateProfile> {
  final ProfileController _profileController = Get.put(ProfileController());
  var parameter = Get.parameters;
  List<String>? galleryImages;  // To store the gallery images

  @override
  void initState() {
    super.initState();
    galleryImages = Get.arguments; // This gets the gallery images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.editAccountInformation.tr),
      body: Obx(
            () => SingleChildScrollView(
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
                        imageUrl:
                        '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.profileImage}',
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
                                image: FileImage(File(_profileController.coverImagePath.value)),
                                fit: BoxFit.cover)),
                      )
                          : CustomNetworkImage(
                        imageUrl:
                        '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.coverImage}',
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
                //======================> Update Button <========================
                Obx(
                      () => CustomButton(
                      loading: _profileController.updateProfileImagesLoading.value,
                      onTap: () {
                        _profileController.updateProfileImages();
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
                    await _profileController.pickImage(
                        ImageSource.gallery, isProfileImage);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image,
                          size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Gallery'.tr,
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
                    await _profileController.pickImage(
                        ImageSource.camera, isProfileImage);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt,
                          size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Camera'.tr,
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

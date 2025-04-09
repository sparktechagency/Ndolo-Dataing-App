import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndolo_dating/controllers/profile_controller.dart';
import 'package:ndolo_dating/controllers/update_gallery_controller.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_text.dart';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  _UploadPhotosScreenState createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  final UpdateGalleryController _galleryController = Get.put(UpdateGalleryController());
  final ProfileController _profileController = Get.put(ProfileController());
  final ImagePicker _picker = ImagePicker();

  //===================> Method to Pick an image <==========================
  Future<void> pickImage(int index) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _galleryController.imagePaths[index] = pickedFile.path;
      });
    }
  }

  //====================> Method to remove an image <======================
  void removeImage(int index) {
    setState(() {
      _galleryController.imagePaths[index] = '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _profileController.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Obx(()=> Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: AppStrings.uploadPhotos.tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  bottom: 8.h,
                ),
              ),
              Center(
                child: CustomText(
                  text: AppStrings.uploadYourBestPhotos.tr,
                  fontSize: 16.sp,
                  maxLine: 2,
                  bottom: 8.h,
                ),
              ),
              SizedBox(height: 32.h),
              //=========================> Image Section <=======================
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                  ),
                  itemCount: _galleryController.imagePaths.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () => pickImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2.w,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.cardColor,
                            ),
                            child: _galleryController.imagePaths[index].isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.file(
                                      File(_galleryController.imagePaths[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.bottomRight,
                                    child: SvgPicture.asset(
                                        AppIcons.add,
                                        width: 31.w, height: 31.h
                                    ),
                                  ),
                          ),
                        ),
                        if (_galleryController.imagePaths[index].isNotEmpty)
                          Positioned(
                            bottom: 2.h,
                            right: 2.w,
                            child: GestureDetector(
                              onTap: () => removeImage(index), // Remove image
                              child: SvgPicture.asset(AppIcons.cancel,
                                  width: 31.w, height: 31.h),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              //=========================> Next Button <=======================
              Obx(()=> CustomButton(
                  loading: _galleryController.uploadGalleryLoading.value,
                    onTap: () {
                    _galleryController.uploadGalleryImages(isUpdate: Get.arguments as bool);
                    },
                    text: AppStrings.next.tr),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }
}

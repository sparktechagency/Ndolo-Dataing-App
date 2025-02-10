import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import '../../../controllers/ideal_match_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class IdealMatchScreen extends StatefulWidget {
  const IdealMatchScreen({super.key});

  @override
  State<IdealMatchScreen> createState() => _IdealMatchScreenState();
}

class _IdealMatchScreenState extends State<IdealMatchScreen> {
  final IdealMatchController _idealMatchController = Get.put(IdealMatchController());
  String selectedOption = ''.tr;
  final List<Map<String, dynamic>> roleOptions = [
    {
      'title': AppStrings.love.tr,
      'description': AppStrings.livenToHaveOne.tr,
      'icon': AppIcons.love,
      'option': 'Love',
    },
    {
      'title': AppStrings.comeWeStay.tr,
      'description': AppStrings.livenToHelp.tr,
      'icon': AppIcons.come,
      'option': 'Come-We-Stay',
    },
    {
      'title': AppStrings.imFreeToday.tr,
      'description': AppStrings.casualOrReady.tr,
      'icon': AppIcons.today,
      'option': 'I\'m Free Today',
    },
    {
      'title': AppStrings.friends.tr,
      'description': AppStrings.iWantToMeet.tr,
      'icon': AppIcons.friends,
      'option': 'Friends',
    },
    {
      'title': AppStrings.business.tr,
      'description': AppStrings.meetBusinessOriented.tr,
      'icon': AppIcons.business,
      'option': 'Business',
    },
  ];

  @override
  void initState() {
    _idealMatchController.getAllIdealMatch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.finding.tr,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff430750),
                ),
                SizedBox(height: 16.h),
                //=================================> Interests ListView Section <=============================
                Expanded(
                  child: ListView.builder(
                    itemCount: _idealMatchController.idealMatchModel.length,
                    itemBuilder: (context, index) {
                      final role = _idealMatchController.idealMatchModel[index];
                      bool isSelected = _idealMatchController.selectedOption.value == role.title;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _idealMatchController.selectedOption.value = '${role.title}';
                            print('===================> ${role.title}');
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.blue.shade50 : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              CustomNetworkImage(
                                  imageUrl: '${ApiConstants.imageBaseUrl}${role.icon}',
                                  height: 48.h,
                                  width: 48.w,
                                boxShape:
                                BoxShape.circle,
                                backgroundColor: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                             // SvgPicture.asset(role['icon']),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: role.title!,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isSelected
                                              ? AppColors.secondaryColor
                                              : Colors.black,
                                        ),
                                        if (isSelected)
                                          const Icon(
                                            Icons.check_box_rounded,
                                            color: Color(0xff8DB501),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    CustomText(
                                      text: role.subTitle!,
                                      fontSize: 16.sp,
                                      color: Colors.grey.shade700,
                                      maxLine: 2,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //=================================> Continue Button <=============================
                SizedBox(height: 16.h),
                Obx(()=> CustomButton(
                    loading: _idealMatchController.postMatchLoading.value,
                    onTap: () {
                      _idealMatchController.postIdealMatch();
                    },
                    text: 'Continue',
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

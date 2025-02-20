import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ndolo_dating/controllers/match_controller.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import '../../../helpers/route.dart';
import '../../../models/match_model.dart';
import '../../../service/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_button.dart';
import '../../base/custom_network_image.dart';

class MatchesScreen extends StatefulWidget {
  MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final MatchController _matchController = Get.put(MatchController());

  //======================> Method to calculate age from the date of birth <========================
  int calculateAge(MatchModel user) {
    final dateOfBirth = user.dateOfBirth;
    if (dateOfBirth == null) {
      return 0;
    }
    DateTime dob = dateOfBirth;
    DateTime today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
    _matchController.getMatchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(1),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.matches.tr,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      body: Obx(() {
        //===================> Check if loading data or matchModel is empty <===========================
        if (_matchController.matchLoading.value) {
          return const Center(child: CustomPageLoading());
        } else if (_matchController.matchModel.isEmpty) {
          return Center(child: CustomText(text: 'No Matches Found'));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListView.builder(
            itemCount: _matchController.matchModel.length,
            itemBuilder: (context, index) {
              final MatchModel user = _matchController.matchModel[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.cardColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              //========================> Image display <==================
                              CustomNetworkImage(
                                imageUrl: '${ApiConstants.imageBaseUrl}${user.profileImage ?? ""}',
                                height: 145.h,
                                width: 112.w,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.r),
                                  bottomLeft: Radius.circular(8.r),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //========================> Name and age <===========================
                                  CustomText(
                                    text: user.fullName ?? "",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff430750),
                                  ),
                                  CustomText(text: '${calculateAge(user)}'),
                                  //==========================> Location <===============================
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(AppIcons.location, color: AppColors.primaryColor, width: 12.w, height: 12.h),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        text: user.location!.locationName ?? "",
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff430750),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  CustomButton(
                                    width: 116.w,
                                    height: 32.h,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.profileDetailsScreen, parameters: {
                                        '_id': '${user.id}',
                                        'age': '${calculateAge(user)}',
                                      });
                                    },
                                    fontSize: 14.sp,
                                    text: AppStrings.sendMessage.tr,
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Love button
                        Positioned(
                          right: 10.w,
                          top: 5.h,
                          child: SvgPicture.asset(
                            AppIcons.like,
                            color: AppColors.primaryColor,
                            width: 28.w,
                            height: 28.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

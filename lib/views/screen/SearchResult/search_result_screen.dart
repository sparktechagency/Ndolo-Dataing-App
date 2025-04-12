import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../controllers/filter_controller.dart';
import '../../../models/home_user_model.dart';
import '../../../utils/app_colors.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_network_image.dart';

class SearchResultScreen extends StatelessWidget {
  final FilterController _filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search Results'.tr),
      body: Obx(() {
        if (_filterController.filterLoading.value) {
          return const Center(child: CustomPageLoading());
        } else if (_filterController.filteredUsers.isEmpty) {
          return const Center(child: Text("No users found"));
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          itemCount: _filterController.filteredUsers.length,
          itemBuilder: (context, index) {
            final member = _filterController.filteredUsers[index];
            return _memberTile(index + 1, member);
          },
        );
      }),
    );
  }

  //==============================> Member Tile <===============================
  _memberTile(int rank, HomeUserModel member) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.profileDetailsScreen, arguments: member);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyColor, width: 1.w),
        ),
        child: Row(
          children: [
            Text(
              rank.toString(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 12.w),
            CustomNetworkImage(
              imageUrl: member.gallery![0],
              height: 48.h,
              width: 48.w,
              boxShape: BoxShape.circle,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${member.fullName}',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Location: ${member.location}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

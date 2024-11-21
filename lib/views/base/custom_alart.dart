import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_strings.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: 'Success',
              fontSize: 16.sp,
              maxLine: 2,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 120.w,
                    height: 40.h,
                    child: CustomButton(
                      text: 'No',
                      onTap: () {
                        Get.back();
                      },
                      color: Colors.white,
                      textStyle: TextStyle(color: AppColors.primaryColor),
                    )),
                SizedBox(
                    width: 120.w,
                    height: 40.h,
                    child: CustomButton(
                        text: 'Yes',
                        textColor: Colors.white,
                        onTap: () async {})),
              ],
            )
          ],
        ),
        elevation: 12.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(width: 1.w, color: AppColors.primaryColor)));
  }
}

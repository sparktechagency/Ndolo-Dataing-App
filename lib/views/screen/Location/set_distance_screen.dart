import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndolo_dating/controllers/location_controller.dart';
import 'package:ndolo_dating/controllers/update_gallery_controller.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../../utils/app_strings.dart';

class SetDistanceScreen extends StatefulWidget {
  const SetDistanceScreen({super.key});

  @override
  _SetDistanceScreenState createState() => _SetDistanceScreenState();
}

class _SetDistanceScreenState extends State<SetDistanceScreen> {
  final LocationController _locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText(text: AppStrings.distanceLabel.tr, fontSize: 16.sp, fontWeight: FontWeight.bold,),
            const SizedBox(height: 16.0,),
            CustomTextField(
              controller: _locationController.locationDistanceController,
              hintText: AppStrings.distanceHint.tr,
              keyboardType: TextInputType.number,
            ),

            //=========================> Next Button <=======================
            const Spacer(),
            Obx(()=> CustomButton(
                loading: _locationController.setDistanceLoading.value,
                onTap: () {
                  _locationController.setDistance();
                },
                text: AppStrings.next.tr),
            ),
            SizedBox(height: 28.h),
          ],
        ),
      ),
    );
  }
}

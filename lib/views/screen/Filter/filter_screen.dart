import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _minDistance = 0;
  double _maxDistance = 200;
  final List<String> gender = ['Male ', 'Female', 'Other'];
  double _minAge = 0;
  double _maxAge = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Filter'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //=======================> Distance Range Slider <==================
            Text('Distance (Mi)'.tr,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp)),
            const SizedBox(height: 8),
            _distancePriceSlider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _priceTag('Minimum', _minDistance),
                _priceTag('Maximum', _maxDistance),
              ],
            ),
            SizedBox(height: 24.h),
            //=======================> Show Me <==================
            CustomText(
              text: 'Show Me'.tr,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
              bottom: 8.h,
            ),
            //===============================> Dropdowns <======================
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 1.5),
                ),
              ),
              items: gender
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
              hint: Text(
                'Looking for..',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 24.h),
            //=======================> Price Range Slider <==================
            Text('Age'.tr,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp)),
            const SizedBox(height: 8),
            _agePriceSlider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _priceTag('Minimum', _minAge),
                _priceTag('Maximum', _maxAge),
              ],
            ),
            const Spacer(),
            //====================> Fin
            CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.searchResultScreen);
                },
                text: 'Find Friends'),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  //============================> Age Price Slider <===============================
  _distancePriceSlider() {
    return RangeSlider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      values: RangeValues(_minDistance, _maxDistance),
      min: 0,
      max: 200,
      divisions: 200,
      labels: RangeLabels(
          _minDistance.toStringAsFixed(0), _maxDistance.toStringAsFixed(0)),
      onChanged: (values) {
        setState(() {
          _minDistance = values.start;
          _maxDistance = values.end;
        });
      },
    );
  }

  //============================> Age Price Slider <===============================
  _agePriceSlider() {
    return RangeSlider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      values: RangeValues(_minAge, _maxAge),
      min: 0,
      max: 60,
      divisions: 60,
      labels:
          RangeLabels(_minAge.toStringAsFixed(0), _maxAge.toStringAsFixed(0)),
      onChanged: (values) {
        setState(() {
          _minAge = values.start;
          _maxAge = values.end;
        });
      },
    );
  }

  //============================> Price Tag <===============================
  _priceTag(String label, double value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp)),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.blue, width: 1.w),
          ),
          child: Text(value.toStringAsFixed(0),
              style: TextStyle(fontSize: 14.sp, color: Colors.blue)),
        ),
      ],
    );
  }
}

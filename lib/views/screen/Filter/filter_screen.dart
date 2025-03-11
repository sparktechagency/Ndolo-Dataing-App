/*
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
  final List<String> country = ['It\'s come from Api '];
  final List<String> gender = ['Male ', 'Female'];
  final List<String> match = ['Love ', 'Come-We-Stay','I\'m Free Today','Friends', 'Business'];
  double _minAge = 18;
  double _maxAge = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Filter'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //=======================> Country <==================
              CustomText(
                text: 'Country'.tr,
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
                items: country
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
                  'Select Country..',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 24.h),
              //=======================> Distance Range Slider <==================
              Text('Distance (Mi)'.tr,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp)),
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
                text: 'Looking For'.tr,
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
              _agePriceSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _priceTag('Minimum', _minAge),
                  _priceTag('Maximum', _maxAge),
                ],
              ),
              SizedBox(height: 24.h),
              //=======================> Match <==================
              CustomText(
                text: 'Match'.tr,
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
                items: match
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
                  'Matches..',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 24.h),
              //====================> Find Friends Button <=====================
              CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.searchResultScreen);
                  },
                  text: 'Find Friends'),
              SizedBox(height: 16.h),
            ],
          ),
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
      min: 18,
      max: 80,
      divisions: 80,
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
*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/home_controller.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../controllers/ideal_match_controller.dart';
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
  final HomeController homeController = Get.find();
  final IdealMatchController _idealMatchController = Get.put(IdealMatchController());

  double _minDistance = 0;
  double _maxDistance = 200;
  double _minAge = 18;
  double _maxAge = 80;
  String? selectedGender;
  String? selectedMatch;

  final List<String> genderOptions = ['Male', 'Female'];
 // final List<String> matchOptions = ['Love', 'Come-We-Stay', 'I\'m Free Today', 'Friends', 'Business'];
  List<String> matchOptions = [];
  Map<String, String> matchIdMap = {};
  void _applyFilters() {
    String idealMatchId = matchIdMap[selectedMatch ?? ''] ?? '';
    homeController.getFilteredUsers(
      maxDistance: _maxDistance,
      minAge: _minAge,
      maxAge: _maxAge,
      gender: selectedGender,
      matchPreference: idealMatchId,
    );
    Get.toNamed(AppRoutes.searchResultScreen, arguments: homeController.filteredUsers);
  }

  @override
  void initState() {
    _idealMatchController.getAllIdealMatch().then((_) {
      setState(() {
        matchOptions = _idealMatchController.idealMatchModel
            .map((e) => e.title ?? 'Unknown')
            .toList();
        matchIdMap = Map.fromIterable(
          _idealMatchController.idealMatchModel,
          key: (item) => item.name ?? 'Unknown',
          value: (item) => item.id ?? '',
        );
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Filter'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //=======================> Distance Slider <==================
              CustomText(
                text: 'Distance (Mi)'.tr,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                bottom: 8.h,
              ),
              _distanceSlider(),
              _rangeLabels('Minimum', _minDistance, 'Maximum', _maxDistance),

              SizedBox(height: 24.h),

              //=======================> Age Range Slider <==================
              CustomText(
                text: 'Age'.tr,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                bottom: 8.h,
              ),
              _ageSlider(),
              _rangeLabels('Minimum', _minAge, 'Maximum', _maxAge),

              SizedBox(height: 24.h),

              //=======================> Gender Dropdown <==================
              CustomText(
                text: 'Looking For'.tr,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                bottom: 8.h,
              ),
              _dropdownField(genderOptions, selectedGender, (value) {
                setState(() {
                  selectedGender = value;
                });
              }, 'Select Gender'),

              SizedBox(height: 24.h),

              //=======================> Match Dropdown <==================
              CustomText(
                text: 'Match'.tr,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                bottom: 8.h,
              ),
              matchOptions.isEmpty
                  ? const CustomPageLoading()
                  : _dropdownField(matchOptions, selectedMatch, (value) {
                setState(() {
                  selectedMatch = value;
                });
              }, 'Select Match'),

              SizedBox(height: 32.h),

              //====================> Find Friends Button <=====================
              CustomButton(
                onTap: _applyFilters,
                text: 'Find Friends',
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  //============================> Distance Slider <===============================
  Widget _distanceSlider() {
    return RangeSlider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      values: RangeValues(_minDistance, _maxDistance),
      min: 0,
      max: 200,
      divisions: 200,
      labels: RangeLabels(_minDistance.toStringAsFixed(0), _maxDistance.toStringAsFixed(0)),
      onChanged: (values) {
        setState(() {
          _minDistance = values.start;
          _maxDistance = values.end;
        });
      },
    );
  }

  //============================> Age Slider <===============================
  Widget _ageSlider() {
    return RangeSlider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      values: RangeValues(_minAge, _maxAge),
      min: 18,
      max: 80,
      divisions: 80,
      labels: RangeLabels(_minAge.toStringAsFixed(0), _maxAge.toStringAsFixed(0)),
      onChanged: (values) {
        setState(() {
          _minAge = values.start;
          _maxAge = values.end;
        });
      },
    );
  }

  //============================> Dropdown Field <===============================
  Widget _dropdownField(List<String> options, String? selectedValue, Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white, // Dropdown background color
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Dropdown icon color
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),
      items: options
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: const TextStyle(color: Colors.black), // Selected item text color
          ),
        ),
      )
          .toList(),
      onChanged: onChanged,
      hint: Text(
        hint,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black), // Hint text color
      ),
    );
  }


  //============================> Range Labels <===============================
  Widget _rangeLabels(String label1, double value1, String label2, double value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _rangeTag(label1, value1),
        _rangeTag(label2, value2),
      ],
    );
  }

  Widget _rangeTag(String label, double value) {
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
          child: Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 14.sp, color: Colors.blue)),
        ),
      ],
    );
  }
}

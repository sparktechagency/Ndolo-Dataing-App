import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/filter_controller.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
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
  final FilterController _filterController = Get.put(FilterController());
  final IdealMatchController _idealMatchController =
      Get.put(IdealMatchController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _maxDistance = 200;
  double _minAge = 18;
  double _maxAge = 80;
  String? selectedGender;
  String? selectedMatch;

  final List<String> genderOptions = ['Male', 'Female'];
  List<String> matchOptions = [];
  Map<String, String> matchIdMap = {};

/*  void _applyFilters() {
    String idealMatchId = matchIdMap[selectedMatch ?? ''] ?? '';
    _filterController.getFilteredUsers(
      maxDistance: _maxDistance,
      minAge: _minAge,
      maxAge: _maxAge,
      gender: selectedGender,
      country: _filterController.countryCtrl.text,
      matchPreference: idealMatchId,
    );
    Get.toNamed(AppRoutes.searchResultScreen,
        arguments: _filterController.filteredUsers);
  }*/

  @override
  void initState() {
    super.initState();
    _idealMatchController.getAllIdealMatch().then((_) {
      setState(() {
        if (_idealMatchController.idealMatchModel.isNotEmpty) {
          matchOptions = _idealMatchController.idealMatchModel
              .map((e) => e.title ?? 'Unknown') // Handle null titles
              .toList();
          matchIdMap = {
            for (var item in _idealMatchController.idealMatchModel)
              item.name ?? 'Unknown': item.id ?? ''
          };
        } else {
          matchOptions = [];
          matchIdMap = {};
        }
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
          child: Form(
            key: _formKey,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Distance'.tr,
                        style: TextStyle(fontSize: 12.sp)),
                    SizedBox(height: 4.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.blue, width: 1.w),
                      ),
                      child: Text(_maxDistance.toStringAsFixed(0),
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.blue)),
                    ),
                  ],
                ),
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
                //=======================> Country  <==================
                SizedBox(height: 24.h),
                CustomText(
                  text: AppStrings.country.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  onTab: () {
                    _filterController.pickCountry(context);
                  },
                  readOnly: true,
                  controller: _filterController.countryCtrl,
                  hintText: 'Enter Country'.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select your country".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
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
                  loading: _filterController.filterLoading.value,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _filterController.getFilteredUsers(
                          maxDistance: _maxDistance,
                          minAge: _minAge,
                          maxAge: _maxAge,
                          gender: selectedGender,
                          country: _filterController.countryCtrl.text,
                          matchPreference: selectedMatch);
                    }
                  },
                  text: 'Find Friends'.tr,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //============================> Distance Slider <===============================
  Widget _distanceSlider() {
    return Slider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      value: _maxDistance,
      min: 0,
      max: 200,
      divisions: 200,
      label: _maxDistance.toStringAsFixed(0),
      onChanged: (value) {
        setState(() {
          _maxDistance = value;
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

  //============================> Dropdown Field <===============================
  Widget _dropdownField(List<String> options, String? selectedValue,
      Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
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
                style: const TextStyle(color: Colors.black),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      hint: Text(
        hint,
        style: TextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black),
      ),
    );
  }

  //============================> Range Labels <===============================
  Widget _rangeLabels(
      String label1, double value1, String label2, double value2) {
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
          child: Text(value.toStringAsFixed(0),
              style: TextStyle(fontSize: 14.sp, color: Colors.blue)),
        ),
      ],
    );
  }
}

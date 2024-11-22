import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_text.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _birthDateCTRL = TextEditingController();
  final TextEditingController _locationCTRL = TextEditingController();
  final TextEditingController _bioCTRL = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? selectedInterest;
  List<String> interestList = [
    'Movie',
    'Snooker',
    'Book Reading',
    'Swimming',
    'Design',
    'Photography',
    'Music',
    'Shopping',
    'Cooking',
    'Art',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomText(
                    text: AppStrings.success.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    bottom: 8.h,
                  ),
                ),
                Center(
                  child: CustomText(
                    text: AppStrings.congratulationsYouHaveSuccessfully.tr,
                    fontSize: 16.sp,
                    maxLine: 2,
                  ),
                ),
                SizedBox(height: 24.h),
                //==========================> Date OF Birth Date Text Field <======================
                CustomText(
                  text: AppStrings.dateOfBirth.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  onTab: () {
                    _pickBirthDate(context);
                  },
                  readOnly: true,
                  controller: _birthDateCTRL,
                  hintText: 'DD-MM-YYYY',
                  suffixIcons: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SvgPicture.asset(AppIcons.calenderIcon)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a date";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=============================> Gender Selection <==============================
                CustomText(
                  text: AppStrings.gender.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                _genderRadioButton(),
                SizedBox(height: 16.h),
                //==========================> Location Text Field <======================
                CustomText(
                  text: AppStrings.location.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _locationCTRL,
                  hintText: AppStrings.enterYourAddress.tr,
                  suffixIcons: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SvgPicture.asset(AppIcons.location)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //==========================> Bio Text Field <======================
                CustomText(
                  text: AppStrings.bio.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _bioCTRL,
                  hintText: AppStrings.writeShortBio.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your bio";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //==========================> Interest Dropdown <====================
                CustomText(
                  text: AppStrings.selectInterest.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  bottom: 8.h,
                ),
                _interestDropDown(),
                //=========================> Complete Profile Button <================
                SizedBox(height: 24.h),
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.offAllNamed(AppRoutes.signInScreen);
                      }
                    },
                    text: AppStrings.completeProfile.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //=========================> Gender Radio Button <================
  _genderRadioButton() {
    return Row(
      children: [
        InkWell(
          onTap: () => setState(() {
            selectedGender = 'Male';
          }),
          child: Row(
            children: [
              Radio<String>(
                value: 'Male',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.deepPurple;
                  }
                  return AppColors.primaryColor;
                }),
              ),
              CustomText(
                text: AppStrings.male.tr,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => setState(() {
            selectedGender = 'Female';
          }),
          child: Row(
            children: [
              Radio<String>(
                value: 'Female',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.deepPurple;
                  }
                  return AppColors.primaryColor;
                }),
              ),
              CustomText(
                text: AppStrings.female.tr,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  //=========================> Interest Drop Down Button <================
  _interestDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedInterest,
          dropdownColor: AppColors.fillColor,
          menuWidth: 265.w,
          borderRadius: BorderRadius.circular(16.r),
          hint: CustomText(
            text: AppStrings.selectInterest.tr,
            color: AppColors.greyColor,
            fontSize: 18.sp,
          ),
          icon: SvgPicture.asset(
            AppIcons.downArrow,
            width: 24.w,
          ),
          isExpanded: true,
          items: interestList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedInterest = newValue;
            });
          },
        ),
      ),
    );
  }

  //==========================> Show Calender Function <=======================
  Future<void> _pickBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: Colors.black, // Text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _birthDateCTRL.text =
            "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_text_field.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../models/interests_model.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_text.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final AuthController _authController  = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedGender;

  @override
  void initState() {
    _authController.getAllInterest();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Obx(()=> SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                    controller: _authController.birthDateCTRL,
                    hintText: 'DD-MM-YYYY',
                    suffixIcons: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  //==========================> Address Text Field <======================
                  CustomText(
                    text: AppStrings.address.tr,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    bottom: 8.h,
                  ),
                  CustomTextField(
                    controller: _authController.addressCTRL,
                    hintText: AppStrings.enterYourAddress.tr,
                    suffixIcons: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    controller: _authController.bioCTRL,
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
                    text: AppStrings.interest.tr,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    bottom: 8.h,
                  ),
                  _interestDropDown(),
                  SizedBox(height: 16.h),
                  //==========================> Show Interest Options Select After Dropdown <======================
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: _authController.selectedInterests.map((interest) {
                      return Chip(
                        label: Text(interest),
                        backgroundColor: AppColors.primaryColor,
                        labelStyle: const TextStyle(color: Colors.white),
                        deleteIcon: Icon(Icons.clear, size: 18.w, color: Colors.white),
                        onDeleted: () {
                          setState(() {
                            _authController.selectedInterests.remove(interest);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  //=========================> Complete Profile Button <================
                  SizedBox(height: 24.h),
                  CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Get.offAllNamed(AppRoutes.signInScreen);
                        }
                      },
                      text: AppStrings.completeProfile.tr),
                  SizedBox(height: 24.h),
                ],
              ),
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
                value: 'male',
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
                value: 'female',
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

//=========================> Interest Multi-Select Drop Down Button <================
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
          value: null,
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
          items: _authController.interestsModel.map((InterestsModel interest) {
            return DropdownMenuItem<String>(
              value: interest.name,
              child: Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primaryColor,
                    focusColor: AppColors.primaryColor,
                    checkColor: AppColors.whiteColor,
                    side: BorderSide(color: AppColors.primaryColor),
                    value: _authController.selectedInterests.contains(interest.name),
                    onChanged: (bool? isSelected) {
                      setState(() {
                        if (isSelected != null && isSelected) {
                          _authController.selectedInterests.add(interest.name!);
                        } else {
                          _authController.selectedInterests.remove(interest.name!);
                        }
                      });
                    },
                  ),
                  Text(interest.name!, style: const TextStyle(color: Colors.black)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _authController.selectedInterests.contains(value);
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
        _authController.birthDateCTRL.text =
        "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
      });
    }
  }
}

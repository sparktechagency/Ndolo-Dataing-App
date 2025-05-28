import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

/*  @override
  void initState() {
    _authController.getAllInterest();
    // TODO: implement initState
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    _authController.getAllInterest();
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


                  //==========================> Country Text Field <======================
                  CustomText(
                    text: AppStrings.country.tr,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    bottom: 8.h,
                  ),
                  CustomTextField(
                    onTab: () {
                      _authController.pickCountry(context);
                    },
                    readOnly: true,
                    controller: _authController.countryCTRL,
                    hintText: AppStrings.country.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your country";
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
                    maxLines: 5,
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
                  /*Wrap(
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
                  ),*/
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: _authController.interestsModel.where((interest) => _authController.selectedInterests.contains(interest.id)).map((interest) {
                      return Chip(
                        label: Text(interest.name ?? ''),
                        backgroundColor: AppColors.primaryColor,
                        labelStyle: const TextStyle(color: Colors.white),
                        deleteIcon: Icon(Icons.clear, size: 18.w, color: Colors.white),
                        onDeleted: () {
                          setState(() {
                            _authController.selectedInterests.remove(interest.id);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  //=========================> Complete Profile Button <================
                  SizedBox(height: 24.h),
                  Obx(()=> CustomButton(
                      loading: _authController.signUpLoading.value,
                        onTap: () {
                          if( _authController.bioCTRL.text.length < 15   ||  _authController.bioCTRL.text.length > 45){
                            Fluttertoast.showToast(msg: "Bio must be between 15 and 45 characters.");
                          }
                          else {
                            if (_formKey.currentState!.validate()) {
                              if (_authController.selectedGender == null){
                                Fluttertoast.showToast(msg: "Select Gender");
                              }
                              else{
                                _authController.handleSignUp();
                              }
                            }
                          }
                        },
                        text: AppStrings.completeProfile.tr),
                  ),
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
            _authController.selectedGender = 'male';
          }),
          child: Row(
            children: [
              Radio<String>(
                value: 'male',
                groupValue: _authController.selectedGender,
                onChanged: (value) {
                  setState(() {
                    _authController.selectedGender = value;
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
            _authController.selectedGender = 'female';
          }),
          child: Row(
            children: [
              Radio<String>(
                value: 'female',
                groupValue: _authController.selectedGender,
                onChanged: (value) {
                  setState(() {
                    _authController.selectedGender = value;
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _authController.selectedInterests.isEmpty
              ? null
              : _authController.selectedInterests.last, // selected ID
          dropdownColor: AppColors.fillColor,
          isExpanded: true,
          hint: CustomText(
            text: AppStrings.selectInterest.tr,
            color: AppColors.greyColor,
            fontSize: 18.sp,
          ),
          icon: SvgPicture.asset(
            AppIcons.downArrow,
            width: 24.w,
          ),
          items: _authController.interestsModel.map((InterestsModel interest) {
            return DropdownMenuItem<String>(
              value: interest.id,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.primaryColor,
                        checkColor: AppColors.whiteColor,
                        side: BorderSide(color: AppColors.primaryColor),
                        value: _authController.selectedInterests.contains(interest.id),
                        onChanged: (bool? isSelected) {
                          setState(() {
                            if (isSelected == true) {
                              if (!_authController.selectedInterests.contains(interest.id)) {
                                _authController.selectedInterests.add(interest.id!);
                              }
                            } else {
                              _authController.selectedInterests.remove(interest.id!);
                            }
                          });
                        },
                      ),
                      Text(interest.name!, style: const TextStyle(color: Colors.black)),
                    ],
                  );
                },
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (!_authController.selectedInterests.contains(value)) {
                _authController.selectedInterests.add(value!);
              } else {
                _authController.selectedInterests.remove(value);
              }
            });
          },
        ),
      ),
    );
  }

  //==========================> Show Calender Function <=======================
  Future<void> _pickBirthDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
      if(isDateValid(pickedDate)){
        setState(() {
          _authController.birthDateCTRL.text = "${_getMonthName(pickedDate.month)} ${pickedDate.day}, ${pickedDate.year}";
        });
      }
      else{
        Fluttertoast.showToast(msg: "The user is younger than 18 years.");
      }
    }
  }

  bool isDateValid(DateTime selectedDate) {
    DateTime today = DateTime.now();
    DateTime eighteenYearsAgo = today.subtract(const Duration(days: 365 * 18)); // 18 years ago

    return selectedDate.isBefore(eighteenYearsAgo);
  }
  // Helper function to convert month number to name
  String _getMonthName(int month) {
    const List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}

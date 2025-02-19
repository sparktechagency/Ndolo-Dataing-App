import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/profile_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_colors.dart';

class ProfileController extends GetxController {

  //=============================> Get Account Data <===============================
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  RxBool profileLoading = false.obs;
  getProfileData() async {
    profileLoading(true);
    var response = await ApiClient.getData(ApiConstants.getProfileEndPoint);
    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(response.body['data']['attributes']);
      profileLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      profileLoading(false);
      update();
    }
  }

  //===============================> Update Profile Data <=============================
  RxString profileImagePath = ''.obs;
  RxString coverImagePath = ''.obs;
  TextEditingController firstNameCTRL = TextEditingController();
  TextEditingController lastNameCTRL = TextEditingController();
  TextEditingController phoneNumberCTRL = TextEditingController();
  TextEditingController dateBirthCTRL = TextEditingController();
  TextEditingController countryCTRL = TextEditingController();
  TextEditingController stateCTRL = TextEditingController();
  TextEditingController cityCTRL = TextEditingController();
  TextEditingController addressCTRL = TextEditingController();
  TextEditingController bioCTRL = TextEditingController();

  var updateProfileLoading = false.obs;
updateProfile() async {
  updateProfileLoading(true);
  Map<String, String> body ={
    'firstName' : firstNameCTRL.text,
    'lastName' : lastNameCTRL.text,
    'phoneNumber' : phoneNumberCTRL.text,
    'dataOfBirth' : dateBirthCTRL.text,
    'country' : countryCTRL.text,
    'state' : stateCTRL.text,
    'city' : cityCTRL.text,
    'address' : addressCTRL.text,
    'bio' : bioCTRL.text,
  };
  List<MultipartBody> multipartBody=[
    MultipartBody('profileImage',File(profileImagePath.value)),
    MultipartBody('coverImage',File(coverImagePath.value)),
  ];

  var response = await ApiClient.patchMultipartData(ApiConstants.updateProfileEndPoint, body, multipartBody: multipartBody);
  if(response.statusCode == 200 || response.statusCode == 201){
    firstNameCTRL.clear();
    lastNameCTRL.clear();
    phoneNumberCTRL.clear();
    dateBirthCTRL.clear();
    countryCTRL.clear();
    stateCTRL.clear();
    cityCTRL.clear();
    addressCTRL.clear();
    bioCTRL.clear();
    profileImagePath.value = '';
    coverImagePath.value = '';
    getProfileData();
    updateProfileLoading(false);
    Get.back();
  } else{
    ApiChecker.checkApi(response);
    updateProfileLoading(false);
    update();
  }
}

  //===============================> Pick Image Function <=============================
  Future<void> pickImage(ImageSource source, bool isProfileImage) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      if (isProfileImage) {
        profileImagePath.value = pickedFile.path;
      } else {
        coverImagePath.value = pickedFile.path;
      }
      update();
    }
    Get.back();
  }

  //===============================> Pick Birth Date <=============================
  Future<void> pickBirthDate(BuildContext context) async {
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
      dateBirthCTRL.text = "${_getMonthName(pickedDate.month)} ${pickedDate.day}, ${pickedDate.year}";
      update();
    }
  }

  // Helper function to convert month number to name
  String _getMonthName(int month) {
    const List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  @override
  void onClose() {
    firstNameCTRL.dispose();
    lastNameCTRL.dispose();
    dateBirthCTRL.dispose();
    countryCTRL.dispose();
    stateCTRL.dispose();
    cityCTRL.dispose();
    addressCTRL.dispose();
    bioCTRL.dispose();
    super.onClose();
  }
}

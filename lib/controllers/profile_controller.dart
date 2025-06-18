import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndolo_dating/helpers/route.dart';
import '../helpers/toast_message_helper.dart';
import '../models/interests_model.dart';
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
    print("my response : ${response.body}");
    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(response.body['data']['attributes']);
      // phoneNumberCTRL.text = profileModel.value.phoneNumber != null ? profileModel.value.phoneNumber.toString() : '';
      // firstNameCTRL.text = profileModel.value.firstName != null ? profileModel.value.firstName.toString() : '';
      // lastNameCTRL.text = profileModel.value.lastName != null ? profileModel.value.lastName.toString() : '';
      // dateBirthCTRL.text =  profileModel.value.dateOfBirth != null ? profileModel.value.dateOfBirth.toString() : '';
      // stateCTRL.text = profileModel.value.state != null ? profileModel.value.state.toString() : '';
      // cityCTRL.text = profileModel.value.city != null ? profileModel.value.city.toString() : '';
      // bioCTRL.text = profileModel.value.bio != null ? profileModel.value.bio.toString() : '' ;
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
  final completePhoneNumberController = TextEditingController();
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
    'callingCode' : completePhoneNumberController.text,
    'dateOfBirth' : dateBirthCTRL.text,
    'country' : countryCTRL.text,
    'state' : stateCTRL.text,
    'city' : cityCTRL.text,
    // 'address' : addressCTRL.text,
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


RxBool updateProfileImagesLoading = false.obs;
  updateProfileImages() async {
    updateProfileImagesLoading(true);


    List<MultipartBody> multipartBody= [


    ];

    if(profileImagePath.value.isNotEmpty){
      multipartBody.add(MultipartBody('profileImage',File(profileImagePath.value)));
    }

    if(coverImagePath.value.isNotEmpty){
      multipartBody.add(MultipartBody('coverImage',File(coverImagePath.value)));
    }


    var response = await ApiClient.patchMultipartData(ApiConstants.updateProfileEndPoint, {}, multipartBody: multipartBody);
    if(response.statusCode == 200 || response.statusCode == 201){
      profileImagePath.value = '';
      coverImagePath.value = '';
      updateProfileImagesLoading(false);
      Get.back();
      getProfileData();
    } else{
      ApiChecker.checkApi(response);
      updateProfileImagesLoading(false);
      update();
    }
  }


  //==========================> Get All Interest Method <============================
  RxList<InterestsModel> interestsModel = <InterestsModel>[].obs;
  RxList selectedInterests = [].obs;
  var interestsLoading = false.obs;
  getAllInterest() async {
    interestsLoading(true);
    var response = await ApiClient.getData(ApiConstants.interestEndPoint);
    if (response.statusCode == 200) {
      interestsModel.value = List<InterestsModel>.from(response.body['data']
      ['attributes']['results']
          .map((x) => InterestsModel.fromJson(x)));
      interestsModel.refresh();
      interestsLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      interestsLoading(false);
      update();
    }
  }

  //==========================> Update Profile After Google Sign In Loading Method <============================
  String selectedGender = '';
  var updateProfileAfterGoogleSignInLoading = false.obs;
  Future<void> updateProfileAfterGoogleSignIn() async {
    updateProfileAfterGoogleSignInLoading.value = true;
    Map<String, dynamic> body ={
      'firstName' : firstNameCTRL.text,
      'lastName' : lastNameCTRL.text,
      'dateOfBirth' : dateBirthCTRL.text,
      'country' : countryCTRL.text,
      'state' : stateCTRL.text,
      'city' : cityCTRL.text,
      'gender': selectedGender,
      'bio' : bioCTRL.text,
      "interests": selectedInterests
    };

    var response = await ApiClient.patchData(ApiConstants.updateProfileEndPoint, jsonEncode(body) );
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
      updateProfileAfterGoogleSignInLoading(false);
      Get.toNamed(AppRoutes.uploadPhotosScreen, arguments: false);
    } else{
      ApiChecker.checkApi(response);
      updateProfileAfterGoogleSignInLoading(false);
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

      if(isDateValid(pickedDate)){
        dateBirthCTRL.text = "${_getMonthName(pickedDate.month)} ${pickedDate.day}, ${pickedDate.year}";
        update();
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


  //======================================> Pick Country Name <========================================
  pickCountry(BuildContext context) async {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        countryCTRL.text = country.name;
        update();
      },
      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(15),
        inputDecoration: InputDecoration(
          hintText: 'Search Countries',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }


  //============================================> Block controller <====================================
  /*RxBool blockLoading = false.obs;
  block({String? id}) async {
    blockLoading(true);
    var params =  {
      "id": "$id",
    };
    var response = await ApiClient.postData(ApiConstants.blockConversationEndPoint(id!), jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      blockLoading(false);
    } else if(response.statusCode == 1){
      blockLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      blockLoading(false);
    }
  }
*/
  //======================================> Report <========================================
  RxBool reportLoading = false.obs;
  report({String? userID, String? title,String? description}) async {
    reportLoading(true);
    var body = {
      "userID": "$userID",
      "title": "$title",
      "description": "$description",
    };
    var response = await ApiClient.postData(
        ApiConstants.reportEndPoint,
        jsonEncode(body)
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("Report submitted successfully!");
      Get.back();
    } else if (response.statusCode == 1) {
      ToastMessageHelper.showToastMessage("Server error! \nPlease try later");
    } else {
      ToastMessageHelper.showToastMessage(response.body["message"]);
    }
  }
}

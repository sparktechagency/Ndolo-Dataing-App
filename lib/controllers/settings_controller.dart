import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import '../helpers/prefs_helpers.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';

class SettingController extends GetxController {
  //==============================> Get Terms and Condition Method <==========================
  var termsConditionLoading = false.obs;
  RxString termContent = ''.obs;
  getTermsCondition() async {
    termsConditionLoading.value = true;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(ApiConstants.termsConditionEndPoint,
        headers: header);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'][0]['content'];
      termContent.value = attributes;
      termsConditionLoading.value = false;
    }
  }

//==========================> Get Privacy Policy Method <=======================
  RxBool getPrivacyLoading = false.obs;
  RxString privacyContent = ''.obs;
  getPrivacy() async {
    getPrivacyLoading.value = true;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(ApiConstants.privacyPolicyEndPoint,
        headers: header);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'][0]['content'];
      privacyContent.value = attributes;
      getPrivacyLoading.value = false;
    }
  }

  //==============================> Get About Us Method <==========================
  RxBool getAboutUsLoading = false.obs;
  RxString aboutContent = ''.obs;
  getAboutUs() async {
    getAboutUsLoading.value = true;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response =
        await ApiClient.getData(ApiConstants.aboutUsEndPoint, headers: header);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'][0]['content'];
      aboutContent.value = attributes;
      getAboutUsLoading.value = false;
    }
  }

  //==============================> Delete Account Method <==========================
  RxBool deleteAccountLoading = false.obs;
  RxString deleteAccountMessage = ''.obs;
  final TextEditingController passwordCTRL = TextEditingController();

  Future<void> deleteAccount() async {
    deleteAccountLoading.value = true;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ApiClient.bearerToken}'
    };
    var body = json.encode({
      "password": passwordCTRL.text,
    });

    final response = await ApiClient.deleteData(
      ApiConstants.deleteAccount,
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("Account deleted successfully: ${response.body}");
      deleteAccountLoading.value = false;
      Get.offAllNamed(AppRoutes.signInScreen);
    } else {
      print("Failed to delete account: ${response.statusText}");
    }
    deleteAccountLoading.value = false;
    ApiChecker.checkApi(response);
    update();
  }
}

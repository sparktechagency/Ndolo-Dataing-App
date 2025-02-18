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

class CommonLocationController extends GetxController {
  var locationNameController = TextEditingController();

  var setLocationLoading = false.obs;

  setLocation({required String latitude, required String longitude}) async {
    try {
      var body = {
        "latitude": latitude,
        "longitude": longitude,
        "locationName": locationNameController.text,
      };
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      //TODO: use real token here ======================>>>
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };

      //TODO: use real token here <<<====================

      setLocationLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.setLocationEndPoint, jsonEncode(body),
          headers: headers);
      print("============> ${response.body} and ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Your Location is set");
        Get.offAllNamed(AppRoutes.homeScreen);
        Fluttertoast.showToast(
            msg: "Your Location is set successfully");
        setLocationLoading(false);
      } else {
        ApiChecker.checkApi(response);
        Fluttertoast.showToast(msg: response.statusText ?? "");
      }
    } catch (e, s) {
      print("===> e : $e");
      print("===> s : $s");
    }
    setLocationLoading(false);
  }


}

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

class LocationController extends GetxController {
  var locationNameController = TextEditingController();
  var setLocationLoading = false.obs;

  setLocation({required String latitude, required String longitude}) async {
      var body = {
        "latitude": latitude,
        "longitude": longitude,
        "locationName": locationNameController.text,
      };
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };
      setLocationLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.setLocationEndPoint, jsonEncode(body),
          headers: headers);
      print("============> ${response.body} and ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        await PrefsHelper.setBool(AppConstants.isFirstTimeUpdateGallery, false);
        print("Your Location is set");
        Get.offAllNamed(AppRoutes.idealMatchScreen);
        Fluttertoast.showToast(msg: "Your Location is set successfully");
        setLocationLoading(false);
      } else {
        ApiChecker.checkApi(response);
        Fluttertoast.showToast(msg: response.statusText ?? "");
      }
    setLocationLoading(false);
  }
}

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
  var locationDistanceController = TextEditingController();
  var setLocationLoading = false.obs;
  var setDistanceLoading = false.obs;

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
    try {
      setLocationLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.setLocationEndPoint, jsonEncode(body),
          headers: headers);
      print("Response: ${response.body}, Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        await PrefsHelper.setBool(AppConstants.hasUpdateGallery, true);
        Fluttertoast.showToast(msg: "Your location is set successfully");
        Get.offAllNamed(AppRoutes.idealMatchScreen);  // Navigate to the next screen
      } else {
        Fluttertoast.showToast(msg: "Failed to update location: ${response.body}");
        print("Failed: ${response.body}");
      }
    } catch (e) {
      print("Error in API call: $e");
      Fluttertoast.showToast(msg: "Error updating location");
    } finally {
      setLocationLoading(false);  // Stop loading state
    }
  }

  setDistance() async {
    var body = {
      "setDistance": int.parse(locationDistanceController.text.trim()),
    };
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      setDistanceLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.setDistanceEndPoint, jsonEncode(body),
          headers: headers);
      print("Response: ${response.body}, Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        await PrefsHelper.setBool(AppConstants.hasUpdateGallery, true);
        Fluttertoast.showToast(msg: "Your location distance is set successfully");
        Get.back();  // Navigate to the next screen
      } else {
        Fluttertoast.showToast(msg: "Failed to update location: ${response.body}");
        print("Failed: ${response.body}");
      }
    } catch (e) {
      setDistanceLoading(false);
      print("Error in API call: $e");
      Fluttertoast.showToast(msg: "Error updating location");
    } finally {
      setDistanceLoading(false);  // Stop loading state
    }
  }

}

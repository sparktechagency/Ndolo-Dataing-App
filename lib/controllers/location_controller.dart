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

    String locationCountry = await PrefsHelper.getString(AppConstants.userCountry);
    String locationState = await PrefsHelper.getString(AppConstants.userState);
    String locationCity = await PrefsHelper.getString(AppConstants.userCity);
    String locationAddress = await PrefsHelper.getString(AppConstants.userAddress);

    var body = {
      "latitude": latitude,
      "longitude": longitude,
      "locationName": locationAddress,
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

      if (response.statusCode == 200 || response.statusCode == 201) {

        await PrefsHelper.setBool(AppConstants.hasUpdateGallery, true);
        await PrefsHelper.setString(AppConstants.userCountry, locationCountry);
        await PrefsHelper.setString(AppConstants.userState, locationState);
        await PrefsHelper.setString(AppConstants.userCity, locationCity);
        await PrefsHelper.setString(AppConstants.userAddress, locationAddress);

        Fluttertoast.showToast(msg: "Your location is set successfully");
        Get.offAllNamed(AppRoutes.idealMatchScreen);
      } else {
        Fluttertoast.showToast(msg: "Failed to update location: ${response.body}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating location");
    } finally {
      setLocationLoading(false);
    }
  }


//=====================================> Set Distance <==============================
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
        Get.back();
      } else {
        print("Failed: ${response.body}");
      }
    } catch (e) {
      setDistanceLoading(false);
      print("Error in API call: $e");
    } finally {
      setDistanceLoading(false);
    }
  }

}

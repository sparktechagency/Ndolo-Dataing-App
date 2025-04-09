import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/prefs_helpers.dart';
import 'package:ndolo_dating/utils/app_constants.dart';

import '../models/home_user_model.dart';
import '../models/single_user_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class HomeController extends GetxController implements GetxService {
  String title = "Home Screen";

  @override
  void onInit() {
    debugPrint("On Init  $title");
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    debugPrint("On onReady  $title");
    super.onReady();
  }

  var userAddress = ''.obs;
  fetchUserAddress() async {
    userAddress.value = await PrefsHelper.getString(AppConstants.userAddress) ?? "N/A";
  }

  //=============================> Get Home All User Data <===============================
  RxList<HomeUserModel> homeUserModel = <HomeUserModel>[].obs;
  RxBool homeLoading = false.obs;
  getUserData() async {
    homeLoading(true);
    var response = await ApiClient.getData(ApiConstants.getHomeAllUserEndPoint);
    if (response.statusCode == 200) {
      homeLoading(false);
      var responseData = response.body['data']['attributes'];
      print("==========================> Raw User Data: $responseData");
      if (responseData is List) {
        homeUserModel.assignAll(
            responseData.map((e) => HomeUserModel.fromJson(e)).toList());
      } else {
        homeUserModel.assignAll([HomeUserModel.fromJson(responseData)]);
        homeLoading(false);
      }
    } else {
      ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    homeLoading(false);
    update();
  }

//=============================> Get Account Data <===============================
  Rx<SingleUserModel> singleUserModel = SingleUserModel().obs;
  RxBool singleLoading = false.obs;
  getSingleUserData(String userID) async {
    singleLoading(true);
    var response =
        await ApiClient.getData(ApiConstants.getSingleUserEndPoint(userID));
    if (response.statusCode == 200) {
      singleUserModel.value =
          SingleUserModel.fromJson(response.body['data']['attributes']);
      singleLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      singleLoading(false);
      update();
    }
  }

//=============================> Post Like User <===============================
  RxBool postLoading = false.obs;
  postUserData(String userID) async {
    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    postLoading(true);
    var body = {
      "profileId": userID,
    };
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var response = await ApiClient.postData(ApiConstants.likeUserEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      postLoading(false);
      print('Response:================> ${response.body}');
    } else {
      ApiChecker.checkApi(response);
     Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    postLoading(false);
    update();
  }

  //=============================> Get Filtered Users <===============================
  RxList<HomeUserModel> filteredUsers = <HomeUserModel>[].obs;
  RxBool filterLoading = false.obs;

  getFilteredUsers({
    required double maxDistance,
    required double minAge,
    required double maxAge,
    String? gender,
    String? country,
    String? city,
    String? matchPreference,
  }) async {
    filterLoading(true);
    String queryParams = '?maxDistance=$maxDistance&minAge=$minAge&maxAge=$maxAge';
    if (gender != null) queryParams += '&gender=$gender';
    if (country != null && country.isNotEmpty) queryParams += '&country=$country';
    if (city != null && city.isNotEmpty) queryParams += '&city=$city';
    if (matchPreference != null) queryParams += '&idealMatch=$matchPreference';
    var response = await ApiClient.getData('${ApiConstants.getHomeAllUserEndPoint}$queryParams');

    if (response.statusCode == 200) {
      filterLoading(false);
      var responseData = response.body['data']['attributes'];
      print("==========================> Filtered User Data: $responseData");
      if (responseData is List) {
        filteredUsers.assignAll(
            responseData.map((e) => HomeUserModel.fromJson(e)).toList());
      } else {
        filteredUsers.assignAll([HomeUserModel.fromJson(responseData)]);
      }
    } else {
      ApiChecker.checkApi(response);
    }

    filterLoading(false);
    update();
  }
}

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
      Fluttertoast.showToast(msg: response.statusText ?? "");
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
     // Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    postLoading(false);
    update();
  }
}

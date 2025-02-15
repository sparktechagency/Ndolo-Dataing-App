import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/home_user_model.dart';
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

  //=============================> Get Account Data <===============================

  RxList<HomeUserModel> homeUserModel = <HomeUserModel>[].obs;
  RxBool homeLoading = false.obs;
  getUserData() async {
    homeLoading(true);
    var response = await ApiClient.getData(ApiConstants.getHomeAllUserEndPoint);
    if (response.statusCode == 200) {
      var responseData = response.body['data']['attributes'];
      print("==========================> Raw User Data: $responseData");
      if (responseData is List) {
        homeUserModel.assignAll(responseData.map((e) => HomeUserModel.fromJson(e)).toList());
      } else {
        homeUserModel.assignAll([HomeUserModel.fromJson(responseData)]);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    homeLoading(false);
    update();
  }


/*
  Rx<HomeUserModel> homeUserModel = HomeUserModel().obs;
  RxBool homeLoading = false.obs;
  getUserData() async {
    homeLoading(true);
    var response = await ApiClient.getData(ApiConstants.getHomeAllUserEndPoint);
    if (response.statusCode == 200) {
      homeUserModel.value = HomeUserModel.fromJson(response.body['data']['attributes']);
      homeLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      homeLoading(false);
      update();
    }
  }*/
}

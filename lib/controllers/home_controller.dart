import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
        homeUserModel.assignAll(responseData.map((e) => HomeUserModel.fromJson(e)).toList());
      } else {
        homeUserModel.assignAll([HomeUserModel.fromJson(responseData)]);
        homeLoading(false);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    homeLoading(false);
    update();
  }

//=============================> Get Account Data <===============================
  Rx<SingleUserModel> singleUserModel = SingleUserModel().obs;
  RxBool singleLoading = false.obs;
  getSingleUserData(String userID) async {
    singleLoading(true);
    var response = await ApiClient.getData(ApiConstants.getSingleUserEndPoint(userID));
    if (response.statusCode == 200) {
      singleUserModel.value = SingleUserModel.fromJson(response.body['data']['attributes']);
      singleLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      singleLoading(false);
      update();
    }
  }


//=============================> Post Like User <===============================
  /*RxBool postLoading = false.obs;
  RxBool postSuccess = false.obs;
  postUserData(String userID) async {
    postLoading(true);
    var body = {
      "profileId": forgetEmailTextCtrl.text.trim(),
    };
    var response = await ApiClient.postData(ApiConstants.likeUserEndPoint(userID), body);
    request.body = json.encode(postData); // Passing dynamic data in the body
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Success, mark postSuccess as true
        postSuccess(true);
        var responseString = await response.stream.bytesToString();
        print('Response: $responseString'); // You can handle the response here as needed
      } else {
        // Handle error responses
        ApiChecker.checkApi(response);
        postSuccess(false);
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
      postSuccess(false);
    } finally {
      postLoading(false); // Hide loading state
      update(); // Update the state in the controller
    }
  }
  */
  

}

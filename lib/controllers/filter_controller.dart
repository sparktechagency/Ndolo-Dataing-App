import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ndolo_dating/helpers/prefs_helpers.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/utils/app_constants.dart';
import '../models/home_user_model.dart';

class FilterController extends GetxController {
  final TextEditingController countryCtrl = TextEditingController();

  //=============================> Get Filtered Users <===============================
  RxList<HomeUserModel> filteredUsers = <HomeUserModel>[].obs;
  RxBool filterLoading = false.obs;
  var token = PrefsHelper.token;
  //=============================> Dynamic API Call <===============================
  getFilteredUsers({
    required double maxDistance,
    required double minAge,
    required double maxAge,
    String? gender,
    String? country,
    String? matchPreference,
  }) async {
    filterLoading(true);
    String queryParams = '?maxDistance=$maxDistance&minAge=$minAge&maxAge=$maxAge';
    if (gender != null) queryParams += '&gender=$gender';
    if (country != null && country.isNotEmpty) {
      queryParams += '&country=$country';
    }
    if (matchPreference != null) queryParams += '&idealMatch=$matchPreference';
    var headers = {
      'Authorization': token,
    };

    try {
      // Send the GET request
      var request = http.Request(
        'GET', Uri.parse('${ApiConstants.baseUrl}/users/all/profiles$queryParams'),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("==========================> Filtered User Data: $responseData");

        // Parse the response dynamically
        var parsedData = ApiClient.parseResponse(responseData);

        // Assuming the response has a list of users
        if (parsedData is List) {
          filteredUsers.assignAll(parsedData.map((e) => HomeUserModel.fromJson(e)).toList());
        } else {
          filteredUsers.assignAll([HomeUserModel.fromJson(parsedData)]);
        }
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
    }

    filterLoading(false);
    update();
  }


  //======================================> Pick Country Name <========================================
  pickCountry(BuildContext context) async {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        countryCtrl.text = country.name;
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
}

class ApiClient {
  static dynamic parseResponse(String response) {
    try {
      final Map<String, dynamic> data = json.decode(response);
      return data['data']['attributes']['users'] ?? [];
    } catch (e) {
      print('Error parsing response: $e');
      return [];
    }
  }
}

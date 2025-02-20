import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helpers/toast_message_helper.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';

class MessageLocationController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  var currentPosition = Rxn<Position>();
  var selectedLocation = Rxn<LatLng>();
  var markers = <Marker>{}.obs;
  var locationAddress = ''.obs;
  LatLng up_location = const LatLng(-6.2088, 106.8456);

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(-6.2088, 106.8456), // Default location (Jakarta)
    zoom: 14.0,
  );

  // Loading state for location update
  RxBool updateLocationLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  //=============================> Check Permission <====================
  Future checkPermission() async {
    final permission = await Permission.camera.status;
    final audio = await Permission.microphone.status;

    print("permission camera : $permission");
    print("audio : $audio");

    if (!permission.isGranted) {
      await Permission.camera.request().then((value) async {
        if (!audio.isGranted) {
          await Permission.microphone.request();
        }
      });
    } else {
      if (!audio.isGranted) {
        await Permission.microphone.request();
      }
    }

    return Future.value(true);
  }

  //=============================> Get the user's current location <====================
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.');
      return;
    }

    //==================> Get current position <================================
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition.value = position;
    up_location = LatLng(position.latitude, position.longitude);
    // Add marker for the current location
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'You are here'),
      ),
    );
    goToCurrentLocation();
  }

  //========================> Move the camera to the current location <==================
  Future<void> goToCurrentLocation() async {
    final controller = await mapController.future;
    if (currentPosition.value != null) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(
            currentPosition.value!.latitude, currentPosition.value!.longitude),
        zoom: 14.0,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  //=============================> Get address from latitude and longitude <=============================
  Future<String?> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}, ${place.country}';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve address.');
    }
    return null;
  }

  //=====================> Handle user tapping on the map <================================
  void onMapTapped(LatLng location) async {
    String? address = await getAddressFromLatLng(location);
    selectedLocation.value = location;
    up_location = location;
    markers.add(
      Marker(
        markerId: const MarkerId('selectedLocation'),
        position: location,
        infoWindow: InfoWindow(title: 'Selected Location', snippet: address),
      ),
    );

    if (address != null) {
      print('===============================> $address');
      locationAddress.value = address;
    }
  }

  //====================> Confirm the selected location and return it to the previous screen <===========================
  void confirmLocation(BuildContext context) {
    if (selectedLocation.value != null) {
      Get.back(result: {
        "address": locationAddress.value,
        "latitude": selectedLocation.value!.latitude.toString(),
        "longitude": selectedLocation.value!.longitude.toString(),
      });
    } else {
      Get.snackbar('Error', 'Please select a location on the map.');
    }
  }

  //=================================> Message Location <==================================
  RxBool locationLoading = false.obs;
  messageLocation(
      {String? receiverID,
      String? conversationID,
      String? latitude,
      String? longitude}) async {
    locationLoading(true);

    Map<String, String> body = {
      "receiverID": "$receiverID",
      "conversationID": "$conversationID",
      "latitude": "$latitude",
      "longitude": "$longitude",
    };

    var response = await ApiClient.postData(
        ApiConstants.messageLocationEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      locationLoading(false);
    } else if (response.statusCode == 1) {
      locationLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      locationLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"]);
    }
  }

  //=================================> Message Delete <==================================
  RxBool deleteLoading = false.obs;
  delete({String? id}) async {
    deleteLoading(true);
    var params = {
      "id": "$id",
    };
    var response = await ApiClient.postData(
        ApiConstants.deleteConversationEndPoint(id!), jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      deleteLoading(false);
    } else if (response.statusCode == 1) {
      deleteLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      deleteLoading(false);
    }
  }
}

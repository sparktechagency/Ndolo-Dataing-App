import 'dart:io';
import 'package:get/get.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';

class UpdateGalleryController extends GetxController {
  var imagePaths = List<String>.filled(6, '').obs;  // This is an RxList
  var uploadGalleryLoading = false.obs;

  Future<void> uploadGalleryImages() async {
    if (imagePaths.isEmpty) {
      print("No images selected for upload.");
      return;
    }

    var isFirstTimeUpdateGallery = await PrefsHelper.getBool(AppConstants.isFirstTimeUpdateGallery);

    uploadGalleryLoading(true);

    // Prepare multipart body for upload
    List<MultipartBody> multipartBody =
    imagePaths.map((path) => MultipartBody('gallery', File(path))).toList();

    var response = await ApiClient.putMultipartData(
      ApiConstants.updateGalleryEndPoint,
      {},
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Reset the imagePaths after successful upload
      imagePaths.assignAll(List.filled(6, ''));  // Use assignAll to update the RxList

      // Perform navigation based on the first-time flag
      if (isFirstTimeUpdateGallery == false) {
        Get.back();
      } else {
        Get.offAllNamed(AppRoutes.locationScreen);
      }

      // Clearing the list for safety
      imagePaths.assignAll([]);  // Reset the list after upload
    } else {
      ApiChecker.checkApi(response);
    }

    uploadGalleryLoading(false);
  }
}

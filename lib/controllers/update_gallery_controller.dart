import 'dart:io';
import 'package:get/get.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class UpdateGalleryController extends GetxController {
  var imagePaths = List<String>.filled(6, '').obs;
  var uploadGalleryLoading = false.obs;

  Future<void> uploadGalleryImages() async {
    if (imagePaths.isEmpty) {
      print("No images selected for upload.");
      return;
    }
    uploadGalleryLoading(true);
    List<MultipartBody> multipartBody =
        imagePaths.map((path) => MultipartBody('gallery', File(path))).toList();
    var response = await ApiClient.putMultipartData(
      ApiConstants.updateGalleryEndPoint,
      {},
      multipartBody: multipartBody,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      imagePaths.value = List.filled(6, '');
      Get.toNamed(AppRoutes.locationScreen);
      imagePaths.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    uploadGalleryLoading(false);
  }
}

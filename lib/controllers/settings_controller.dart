import 'package:get/get.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class SettingController extends GetxController {
  //==============================> Get Terms and Condition Method <==========================
  var termsConditionLoading = false.obs;
  RxString content = ''.obs;
  getTermsCondition() async {
    termsConditionLoading.value = true;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(ApiConstants.termsConditionEndPoint,
        headers: header);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'][0]['content'];
      content.value = attributes;
      termsConditionLoading.value = false;
    }
  }

//==========================> Get Privacy Policy Method <=======================
  RxBool getPrivacyLoading = false.obs;
  RxString contents = ''.obs;
  getPrivacy() async {
    getPrivacyLoading.value = true;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(ApiConstants.privacyPolicyEndPoint,
        headers: header);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'][0]['content'];
      contents.value = attributes;
      getPrivacyLoading.value = false;
    }
  }

  //==============================> Get About Us Method <==========================
  RxBool getAboutUsLoading = false.obs;
  RxString contented = ''.obs;
  getAboutUs() async {
    getAboutUsLoading.value = true;
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(ApiConstants.aboutUsEndPoint, headers: header);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'][0]['content'];
      contented.value = attributes;
      getAboutUsLoading.value = false;
    }
  }
}

import 'package:get/get.dart';
import '../models/match_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class MatchController extends GetxController {

//=============================> Get Matches Data <===============================
  RxList<MatchModel> matchModel = <MatchModel>[].obs;
  RxBool matchLoading = false.obs;
  getMatchData() async {
    matchLoading(true);
    var response = await ApiClient.getData(ApiConstants.getMatchListEndPoint);
    if (response.statusCode == 200) {
      matchLoading(false);
      var responseData = response.body['data']['attributes'];
      if (responseData is List) {
        matchModel.assignAll(responseData.map((e) => MatchModel.fromJson(e)).toList());
      } else {
        matchModel.assignAll([MatchModel.fromJson(responseData)]);
        matchLoading(false);
      }
    }
    else {
      ApiChecker.checkApi(response);
      matchLoading(false);
      update();
    }
  }
}
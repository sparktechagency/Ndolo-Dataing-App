import 'package:get/get.dart';

import '../models/notification_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class NotificationController extends GetxController {
//=============================> Get Notification Data <===============================
  RxList<NotificationModel> notificationModel = <NotificationModel>[].obs;
  RxBool notificationLoading = false.obs;
  getNotificationData() async {
    notificationLoading(true);
    var response = await ApiClient.getData(ApiConstants.notificationEndPoint);
    if (response.statusCode == 200) {
      notificationModel.value = List<NotificationModel>.from(response
          .body['data']['attributes']['notifications']
          .map((x) => NotificationModel.fromJson(x)));
      notificationLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      notificationLoading(false);
      update();
    }
  }
}

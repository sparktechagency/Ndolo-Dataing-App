import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../helpers/prefs_helpers.dart';
import '../../helpers/route.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/conversation_media_model.dart';
import '../../models/message_model.dart';
import '../../models/conversation_model.dart';
import '../../models/get_user_by_model.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../service/socket_services.dart';
import '../../utils/app_constants.dart';

class MessageController extends GetxController {
  RxBool isActive = false.obs;
  RxBool seenMessage = false.obs;
  RxInt page = 1.obs;
  //============================================> Get All Conversation List =========================================>
  RxBool conversationLoading = false.obs;
  RxList<ConversationModel> conversationModel = <ConversationModel>[].obs;
  getConversation() async {
    conversationLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getAllMessageUserEndPoint,
    );
    if (response.statusCode == 200) {
      var data = response.body["data"]['attributes'];
      conversationModel.value = List<ConversationModel>.from(
          data.map((x) => ConversationModel.fromJson(x))
      );
      conversationLoading(false);
    } else {
      conversationLoading(false);
      ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg: '${response.statusText}');
      update();
    }
  }


  //======================================> Get All Message <==================================
  RxInt pages = 1.obs;
  RxBool messageLoading = false.obs;
  RxList<MessageModel> messageModel = <MessageModel>[].obs;
  getMessage(String id) async {
    messageLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getAllSingleMessageEndPoint(id),
    );
    if (response.statusCode == 200) {
      var data = response.body["data"]['attributes']['data'];
      messageModel.value = List<MessageModel>.from(
          data.map((x) => MessageModel.fromJson(x)));
      if (messageModel.last.seen! == 2) {
        seenMessage.value = true;
      } else {
        seenMessage.value = true;
      }
      messageLoading(false);
    } else {
      messageLoading(false);
      ApiChecker.checkApi(response);
    }
  }


  //======================================> Listen User Active Status <==================================
  RxBool userActiveStatus = false.obs;
  void listenUserActiveStatus() {
    try {
      SocketServices().socket.on("active-users", (data) {
        if (data != null) {
          print(
              "=====================> user active status ==: ${data["isActive"]}");
          if (data["isActive"] == true &&
              data["id"] == Get.arguments['receiverID']) {
            isActive.value = true;
          } else {
            isActive.value = false;
          }
        }
      });
    } catch (e, s) {
      print("Error in listenUserActiveStatus: $e");
      print("Stack Trace: $s");
    }
  }

//================================> Emit Function <=============================
  void emitUserActiveStatus(bool isActive) {
    try {
      SocketServices().socket.emit("active-inactive", {"myId": Get.arguments});
      print("================> User active-inactive emitted: $isActive");
    } catch (e, s) {
      print("Error in emitUserActiveStatus: $e");
      print("Stack Trace: $s");
    }
  }

//================================> SendMessage Function <=============================
  void sendMessage(String content, String receiverID, String conversationID) {
    final messagePayload = {
      "conversationID": conversationID,
      "receiverID": receiverID,
      "content": content,
    };
    SocketServices().emit('send-message', messagePayload);
  }

  //================================> Send Seen Emit Function <=============================
  void sendSeenEmit({required String conversationId}) {
    final messagePayload = {
      "conversationID": conversationId,
    };
    SocketServices().emit('seen', messagePayload);
  }

  //================================> Listen Message Function <=============================
  void listenMessage(String coversationId) async {
    try {
      // Listen for text messages
      SocketServices().socket.on("conversation-$coversationId", (data) {
        if (data != null) {
          final newMessage = MessageModel.fromJson(data);
          messageModel.insert(0, newMessage);
          seenMessage.value = false;
          print("=============================> $data");
          update();
        }
      });
      SocketServices().socket.on("seen-$coversationId", (data) {
        if (data != null) {
          if (data["seenBy"] == Get.arguments['receiverID']) {
            seenMessage.value = true;
          }
          print(Get.arguments['receiverID']);
          print("===========================> $data");
          update();
        }
      });
      print("Listening for messages and images...");
    } catch (e, s) {
      print("Error in listenMessage: $e");
      print("StackTrace: $s");
    }
  }

  //================================> Send Message With Image <=============================
  sendMessageWithImage(
    String conversationID,
    String receiverID,
    File? files,
  ) async {
    List<MultipartBody> multipartBody =
        files == null ? [] : [MultipartBody("files", files)];
    var body = {
      "conversationID": conversationID,
      "receiverID": receiverID,
      "files": '$files',
    };
    var response = await ApiClient.postMultipartData(
      ApiConstants.messageEndPoint,
      body,
      multipartBody: multipartBody,
    );
  }

  //================================> Message Location <=============================
  /*RxBool locationLoading = false.obs;
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
  }*/

  //================================> Get Conversation Media <=============================
  /*RxInt conversationPage = 1.obs;
  RxBool conversationMediaLoading = false.obs;
  RxList<ConversationMediaModel> conversationMediaModel =
      <ConversationMediaModel>[].obs;
  getConversationMedia(String id) async {
    conversationMediaLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.conversationMediaEndPoint(
          conversationPage.value.toString(), "16", id),
    );
    if (response.statusCode == 200) {
      var data = response.body["data"];
      conversationMediaModel.value = List<ConversationMediaModel>.from(
          data.map((x) => ConversationMediaModel.fromJson(x)));
      conversationMediaLoading(false);
    } else {
      conversationMediaLoading(false);
      ApiChecker.checkApi(response);
    }
  }*/

  List icebreakerList = [
    "If money wasn’t an issue, what would you spend your life doing?",
    "What’s a book, movie, or podcast that made you see the world differently?",
    "What’s one quote or saying that really resonates with you, and why?"
  ];

  //=============================> Message Participant <=============================
  RxBool conversationParticipant = false.obs;
  messageParticipant({required String id}) async {
    conversationParticipant(true);
    var params = {
      "participant": id,
    };
    try {
      var response = await ApiClient.postData(
        ApiConstants.getAllSingleMessageEndPoint(id),
        jsonEncode(params),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var createdConversationID = response.body["data"]["attributes"]['id'];
        try {
          messageLoading(true);
          var response = await ApiClient.getData(
            ApiConstants.getAllMessageUserEndPoint,
          );
          if (response.statusCode == 200) {
            messageModel.value = List<MessageModel>.from(
              response.body["data"].map((x) => MessageModel.fromJson(x)),
            );
            var message = messageModel.value.firstWhere(
              (conv) => conv.id == createdConversationID,
            );
            if (message != null) {
              print("✅ Conversation Found: ${message.msgByUserId!.fullName}");

              Get.toNamed(AppRoutes.chatScreen, arguments: {
                "id": message.id,
                "name": message.msgByUserId!.fullName,
                "image": '${ApiConstants.imageBaseUrl}/${message.msgByUserId!.image}',
                "receiverID":message.msgByUserId!.id,
                "conversationID": message.id,
                "email": message.msgByUserId!.email
              });
            } else {
              print("❌ Message Not Found");
            }
            print("MY Response ${response.body['data']}");
            messageLoading(false);
          } else {
            messageLoading(false);
            ApiChecker.checkApi(response);
          }
        } catch (e) {
          messageLoading(false);
        }
        // Get.offNamed(AppRoutes.messageScreen);
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
      } else {
        ToastMessageHelper.showToastMessage(
            response.body["message"] ?? "Something went wrong");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } finally {
      conversationParticipant(false);
    }
  }

  //========================> profile name new <==================================
  RxBool getUserLoading = false.obs;
  Rx<GetUserByIdModel> getUserId = GetUserByIdModel().obs;
  getUserById(String id) async {
    getUserLoading(true);
    var response =
        await ApiClient.getData(ApiConstants.getUserByIdEndPoint(id));
    print(response.body);
    if (response.statusCode == 200) {
      getUserId.value = GetUserByIdModel.fromJson(response.body['data']);
      getUserLoading(false);
    } else {
      getUserLoading(false);
      ApiChecker.checkApi(response);
    }
  }
}

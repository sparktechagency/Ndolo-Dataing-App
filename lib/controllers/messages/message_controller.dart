import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
import '../../utils/logger.dart';

class MessageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var page = 1;
  RxBool isActive = false.obs;
  RxBool seenMessage = false.obs;
  File? selectedImage;
  RxString imagesPath=''.obs;

  //============================================> Get All Conversation List <========================================
  RxBool conversationLoading = false.obs;
  RxList<ConversationModel> conversationModel = <ConversationModel>[].obs;
  getConversation() async {
    conversationLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getAllConversationEndPoint,
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
  //============================================> Create Conversation  <=========================================
  var isCreatingConversation = false.obs;
  createConversation(String receiverId) async {
    isCreatingConversation(true);
    var response = await ApiClient.postData(
      ApiConstants.createConversationEndPoint(receiverId),
      {"receiver": receiverId},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var currentUserID = await PrefsHelper.getString(AppConstants.userId);
      var data = response.body['data']['attributes'];
      isCreatingConversation(false);
      showInfo("Conversation created successfully.");
      Get.toNamed(AppRoutes.messageScreen, parameters: {
        'conversationId': data['id'],
        'currentUserId': currentUserID,
        'currentUserImage': currentUserID == data['sender']['id'] ? data['sender']['profileImage'] : data['receiver']['profileImage'],
        "receiverImage": currentUserID == data['sender']['id'] ? data['receiver']['profileImage'] : data['sender']['profileImage'],
        "receiverName": currentUserID == data['sender']['id'] ? data['receiver']['fullName'] : data['sender']['fullName'],
        "receiverId": currentUserID == data['sender']['id'] ? data['receiver']['id'] : data['sender']['id'],
      });
    } else {
      ApiChecker.checkApi(response);
      isCreatingConversation(false);
    }
  }


  //======================================> Get All Message <==================================
  RxList<MessageModel> messageModel=<MessageModel>[].obs;
  var inboxpage = 1;
  var inboxfirstLoading=false.obs;
  var inboxloadMoreLoading=false.obs;
  var inboxtotalPage = 0;
  var inboxcurrentPage = 0;

  listenMessage(String conversationId) async {
    SocketServices().socket.on("new-message::$conversationId", (data) {
      debugPrint("=========> Response Message $data");
      MessageModel demoData = MessageModel.fromJson(data);
      messageModel.add(demoData);
      messageModel.refresh();
      update();
    });
  }

  socketOffListen(String conversationId)async{
    SocketServices().socket.off("new-message::$conversationId");
    debugPrint("Socket off New message");
  }



  //========================> All Inbox Message <=================================

  Future inboxFirstLoad(String conversationId)async{
    inboxpage=1;
    inboxfirstLoading(true);
    var response=await ApiClient.getData(ApiConstants.getAllSingleMessageEndPoint(conversationId));
    if(response.statusCode==200){
      messageModel.value= List<MessageModel>.from(response.body['data']['attributes']['data'].map((x) => MessageModel.fromJson(x)));
      inboxcurrentPage=response.body['data']['attributes']['page'];
      inboxtotalPage=response.body['data']['attributes']['totalPages'];
      debugPrint("Current Check>>${inboxcurrentPage}");
      debugPrint("Total Check>>${inboxtotalPage}");
      // rxRequestStatus(Status.completed);
      inboxfirstLoading(false);
      update();
    } else{
      if (ApiClient.noInternetMessage == response.statusText) {
        // setRxRequestStatus(Status.internetError);
      } else
      {
        //setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      inboxfirstLoading.value=false;
      update();
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

  //================================> Send Seen Emit Function <=============================
  void sendSeenEmit({required String conversationId}) {
    final messagePayload = {
      "conversationID": conversationId,
    };
    SocketServices().emit('seen', messagePayload);
  }

    //========================> Sent Message <==================================
    final TextEditingController sentMsgCtrl = TextEditingController();
    var sentMessageLoading = false.obs;
    sentMessage(String conversationId, String type) async {
      sentMessageLoading(true);
      Map<String, dynamic> body = {
        "conversationId": conversationId,
        "type": type,
        "text": sentMsgCtrl.text
      };
      var response = await ApiClient.postData(
        ApiConstants.sentMessageEndPoint, body,);
      if (response.statusCode == 200 || response.statusCode == 201) {
        sentMsgCtrl.clear();
        sentMessageLoading(false);
        update();
      }
      else {
        sentMessageLoading(false);
        update();
      }
    }
    //========================> Sent Image <==================================
    sentImage(String conversationId, String type) async {
      sentMessageLoading(true);
      Map<String, String> body = {
        "conversationId": conversationId,
        "type": type,
      };
      List<MultipartBody> multipartList = [
        MultipartBody(
            "image", File(imagesPath.value)
        )
      ];
      var response = await ApiClient.postMultipartData(
          ApiConstants.sentMessageEndPoint, body, multipartBody: multipartList);
      if (response.statusCode == 200 || response.statusCode == 201) {
        imagesPath.value = '';
        sentMessageLoading(false);
        update();
      }
      else {
        sentMessageLoading(false);
        update();
      }
    }


    //========================> PickImages <==================================
    Future pickImages(ImageSource source) async {
      final returnImage = await ImagePicker().pickImage(source: source);
      if (returnImage == null) return;
      selectedImage = File(returnImage.path);
      imagesPath.value = selectedImage!.path;
      //  image = File(returnImage.path).readAsBytesSync();
      update();
      print('ImagesPath===========================>:${imagesPath.value}');
      // Get.back(); //
    }
  }


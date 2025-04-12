import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../helpers/prefs_helpers.dart';
import '../../helpers/route.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../service/socket_services.dart';
import '../../utils/app_constants.dart';
import '../../models/message_model.dart';
import '../../models/conversation_model.dart';

class MessageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isActive = false.obs;
  RxBool seenMessage = false.obs;
  RxList<MessageModel> messageModel = <MessageModel>[].obs;
  RxBool inboxFirstLoading = false.obs;
  RxBool sentMessageLoading = false.obs;
  var inboxPage = 1;
  var inboxTotalPages = 0;
  var inboxCurrentPage = 0;
  RxBool conversationLoading = false.obs;
  RxList<ConversationModel> conversationModel = <ConversationModel>[].obs;
  RxString imagesPath = ''.obs;
  File? selectedImage;
  final TextEditingController sentMsgCtrl = TextEditingController();
  final SocketServices _socket = SocketServices();

  @override
  void onInit() {
    super.onInit();
    _socket.init();
    conversation();
    message();
  }

  updateMessageScreen(param) async {
    var aa = await Get.toNamed(AppRoutes.chatScreen, parameters: param);
    update();
  }

  //===================================> GET CONVERSATIONS <===================================
  Future<void> conversation() async {
    print('Requesting conversations from the socket...');
    _socket.socket!.on('conversation', (data) {
      if (data != null && data.isNotEmpty) {
        conversationModel.value = List<ConversationModel>.from(data.map((x) {
          ConversationModel conversation = ConversationModel.fromJson(x);
          if (conversation.sender.id == PrefsHelper.userId ||
              conversation.receiver.id == PrefsHelper.userId) {
            return conversation;
          } else {
            return null;
          }
        }).where((conversation) => conversation != null));

        update();
      } else {
        print('No new conversations');
      }
    });
  }
  Future<void> getConversation() async {
    print(PrefsHelper.userId);
    print(AppConstants.bearerToken);
    print('Requesting conversations from the socket...');
    _socket.socket!.emit('conversation-page', {"currentUserId": PrefsHelper.userId});
  }

  //===================================> GET Messages <===================================
  Future<void> getMessage(String receiverID) async {
    print(receiverID);
    print('Requesting messages from the socket...');
    await _socket.init();
    _socket.socket!.emit('message-page', {"receiver": receiverID});
  }

  Future<void> message() async {
    print('Requesting messages from the socket...');
    _socket.socket!.on(
      'message',
          (data) {
        print('Update Message');
        print('=============================> $data');
        if (data != null && data.isNotEmpty) {
          messageModel.value = List<MessageModel>.from(data.map((x) => MessageModel.fromJson(x)));
          update();
        } else {
          print('No new messages or invalid data');
        }
      },
    );
  }

  //===================================> CREATE A NEW CONVERSATION <===================================
  createConversation(String receiverId, {bool isAddFriend = false}) async {
    var response = await ApiClient.postData(
      ApiConstants.createConversationEndPoint(receiverId),
      {"receiver": receiverId},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (isAddFriend) {
        Fluttertoast.showToast(msg: 'Friend Added Successfully');
      } else {
        var currentUserID = await PrefsHelper.getString(AppConstants.userId);
        var data = response.body['data']['attributes'];
        var sender = data['sender'];
        var receiver = data['receiver'];
        var conversationId = data['id'];
        var receiverId =
        currentUserID == sender['id'] ? receiver['id'] : sender['id'];
        var displayImage = currentUserID == sender['id']
            ? receiver['profileImage']
            : sender['profileImage'];
        var displayName = currentUserID == sender['id']
            ? receiver['fullName']
            : sender['fullName'];
        Get.toNamed(AppRoutes.chatScreen, parameters: {
          'conversationId': conversationId,
          'currentUserId': currentUserID,
          'receiverId': receiverId,
          'receiverImage': displayImage,
          'receiverName': displayName,
        });
      }
    } else {
      if (isAddFriend) {
        Fluttertoast.showToast(msg: 'Can not added as a friend');
      }
      ApiChecker.checkApi(response);
    }
  }

  //===================================> LOAD MESSAGES FOR CONVERSATION <===================================
  inboxFirstLoad(String receiverId) async {
    inboxFirstLoading(true);
    var response = await ApiClient.getData(
        ApiConstants.getAllSingleMessageEndPoint(receiverId));
    if (response.statusCode == 200) {
      inboxFirstLoading(false);
      var data = response.body['data']['attributes']['data'];
      messageModel.value =
      List<MessageModel>.from(data.map((x) => MessageModel.fromJson(x)));
    } else {
      ApiChecker.checkApi(response);
    }
    inboxFirstLoading(false);
  }

  //===================================> LISTEN FOR NEW MESSAGES VIA SOCKET <===================================
  bool isListening = false;
  MessageModel newMessage = MessageModel.fromJson({});
  listenMessage(String receiverId) {
    if (_socket.socket == null) return;
    _socket.socket!.off('message');
    _socket.socket!.on("message", (data) {
      final messages = List<Map<String, dynamic>>.from(data);
      debugPrint("🔵 Live Message Received: $messages ");

      for (var item in data) {
        MessageModel receivedMessage = MessageModel.fromJson(item);

        if (!messageModel.any((msg) => msg.id == receivedMessage.id)) {
          messageModel.add(receivedMessage);
          messageModel.refresh();
          Future.delayed(const Duration(milliseconds: 100));
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          }
        }
      }
      update();
    });
  }


  //===================================> SEND A TEXT MESSAGE <===================================
  void sentMessage(String receiverId, String senderId, String text, String msgById) async {
    if (text.isEmpty || sentMessageLoading.value) return;
    if (sentMessageLoading.value) return;
    sentMessageLoading(true);
    try {
      if (_socket.socket != null) {
        _socket.socket?.emit("new-message", {
          "sender": senderId,
          "receiver": receiverId,
          "text": text,
          "msgByUserId": msgById
        });
        final newMessage = MessageModel(
          text: text,
          msgByUserId: senderId,
          createdAt: DateTime.now(),
          type: 'text',
          id: UniqueKey().toString(),
        );
        messageModel.insert(0, newMessage);
        messageModel.refresh();
        update();
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
        });
      } else {
        Fluttertoast.showToast(msg: "WebSocket not connected!");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Socket Error: ${e.toString()}");
    } finally {
      sentMessageLoading(false);
    }
  }

  //===================================> SEND AN IMAGE MESSAGE <===================================
/*
  Future<void> sentImage(String conversationId, String type) async {
    if (imagesPath.value.isEmpty) {
      Fluttertoast.showToast(msg: "No image selected!");
      return;
    }
    sentMessageLoading(true);
    Map<String, String> body = {
      "conversationId": conversationId,
      "type": type,
    };

    List<MultipartBody> multipartList = [
      MultipartBody("image", File(imagesPath.value))
    ];
    SocketServices().emit("new-message", {
      "conversationId": conversationId,
      "type": type,
      "imageUrl": imagesPath.value,
    });
    messageModel.add(MessageModel(
      type: type,
      msgByUserId: await PrefsHelper.getString(AppConstants.userId),
      imageUrl: imagesPath.value,
      createdAt: DateTime.now(),
    ));
    messageModel.refresh();
    update();
    var response = await ApiClient.postMultipartData(
      ApiConstants.sentMessageEndPoint,
      body,
      multipartBody: multipartList,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      imagesPath.value = '';
      listenMessage(conversationId);
      inboxFirstLoad(conversationId);
      sentMessageLoading(false);
      update();
    } else {
      sentMessageLoading(false);
      Fluttertoast.showToast(msg: "Failed to send image!");
      update();
    }
  }
*/
}

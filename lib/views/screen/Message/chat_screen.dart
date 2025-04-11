/*
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../controllers/messages/message_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/time_formate.dart';
import '../../../models/message_model.dart';
import '../../../utils/app_constants.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController _controller = Get.put(MessageController());
  TextEditingController messageController = TextEditingController();
  final params = Get.parameters;
  var conversationId = "";
  var currentUserId = "";
  var currentUserName = "";
  var receiverImage = "";
  var receiverName = "";
  var receiverId = "";
  File? selectedIMage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserId();
      conversationId = Get.parameters['conversationId']!;
      conversationId = params['conversationId'] ?? "";
      if (conversationId.isEmpty) {
        Fluttertoast.showToast(msg: "Invalid conversation ID");
        return;
      }
      currentUserId = params['currentUserId'] ?? "";
      receiverImage = params['receiverImage'] ?? "";
      receiverName = params['receiverName'] ?? "";
      receiverId = params['receiverId'] ?? "";
      _controller.inboxFirstLoad(conversationId);
      _controller.listenMessage(conversationId);
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  getUserId() async {
    currentUserId = await PrefsHelper.getString(AppConstants.userId);
    currentUserName = await PrefsHelper.getString(AppConstants.userName);
    if (kDebugMode) {
      print('currentId ======================> $currentUserId');
      print('currentUserName ======================> $currentUserName');
    }
  }

  Future<void> _refreshMessages() async {
    getUserId();
    _controller.inboxFirstLoad(conversationId);
    _controller.listenMessage(conversationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        titleSpacing: 0.w,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl:
                  "${ApiConstants.imageBaseUrl}${Get.parameters["receiverImage"]}",
              height: 45.h,
              width: 45.w,
              boxShape: BoxShape.circle,
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: CustomText(
                text: "${Get.parameters["receiverName"]}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                maxLine: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => CallMethod(
                      conversationID: conversationId,
                      userID: receiverId,
                      userName: receiverName,
                    config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
                    ));
              },
              child: SvgPicture.asset(AppIcons.audio)),
          SizedBox(width: 16.w),
          InkWell(
              onTap: () {
                Get.to(() => CallMethod(
                      conversationID: conversationId,
                      userID: receiverId,
                      userName: receiverName,
                  config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),

                ));
              },
              child: SvgPicture.asset(AppIcons.video)),
          SizedBox(width: 24.w),
        ],
      ),
      body: Obx(() {
        if (_controller.inboxFirstLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: _refreshMessages,
                        child: GroupedListView<MessageModel, DateTime>(
                          elements: _controller.messageModel.value,
                          controller: _controller.scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          order: GroupedListOrder.DESC,
                          itemComparator: (item1, item2) =>
                              item1.createdAt!.compareTo(item2.createdAt!),
                          groupBy: (MessageModel message) => DateTime(
                              message.createdAt!.year,
                              message.createdAt!.month,
                              message.createdAt!.day),
                          reverse: true,
                          shrinkWrap: true,
                          groupSeparatorBuilder: (DateTime date) {
                            return const SizedBox();
                          },
                          itemBuilder: (context, MessageModel message) {
                            return message.msgByUserId!.id == currentUserId
                                ? senderBubble(context, message)
                                : receiverBubble(context, message);
                          },
                        ),
                      ),
                      //=====================================> Show Select Image <=====================
                      Positioned(
                          bottom: -5.h,
                          child: Column(
                            children: [
                              if (_controller.imagesPath.value.isNotEmpty)
                                Container(
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.file(
                                          File(_controller.imagesPath.value),
                                          height: 120.h,
                                          width: 120.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 4.w,
                                        top: 4.h,
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.imagesPath.value = "";
                                            _controller.update();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black54,
                                            ),
                                            child: Icon(Icons.close,
                                                color: Colors.white,
                                                size: 18.w),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295.w,
                child: CustomTextField(
                  controller: messageController,
                  hintText: "Type something…",
                  suffixIcons: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: GestureDetector(
                        onTap: () {
                          openGallery();
                        },
                        child: SvgPicture.asset(AppIcons.attach,
                            color: AppColors.greyColor)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (messageController.text.isNotEmpty &&
                      !_controller.sentMessageLoading.value) {
                    _controller.sentMessage(
                        conversationId, 'text', messageController.text);
                    messageController.clear();
                  } else if (_controller.imagesPath.value.isNotEmpty) {
                    _controller.sentImage(conversationId, 'image');
                  } else {
                    Fluttertoast.showToast(msg: 'Please write a message');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      AppIcons.sendIcon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //===============================> Receiver Bubble <=============================
  receiverBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
            imageUrl: '${ApiConstants.imageBaseUrl}$receiverImage',
            boxShape: BoxShape.circle,
            height: 38.h,
            width: 38.w),
        SizedBox(width: 8.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: AppColors.cardColor,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                          borderRadius: BorderRadius.circular(8.r),
                          height: 140.h,
                          width: 155.w)
                      : Text(
                          '${message.text}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.start,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //===============================> Sender Bubble <=============================
  senderBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                          borderRadius: BorderRadius.circular(8.r),
                          height: 140.h,
                          width: 155.w)
                      : Text(
                          "${message.text}",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                          textAlign: TextAlign.start,
                        ),
                  Text(
                    '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> openGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _controller.imagesPath.value = pickedFile.path;
      _controller.update();
    }
  }
}

class CallMethod extends StatelessWidget {
  final String userID;
  final String userName;
  final String conversationID;
  final ZegoUIKitPrebuiltCallConfig config;

  const CallMethod({
    Key? key,
    required this.userID,
    required this.userName,
    required this.conversationID,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1059598849,
      appSign: '6ea42a0e9c416a604335cf5d521cc0120cf4244d4dac79a6c0419eba10150a99',
      userID: userID,
      userName: userName,
      callID: conversationID,
      config: config,
    );
  }
}
*/




import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../controllers/messages/message_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/time_formate.dart';
import '../../../models/message_model.dart';
import '../../../service/socket_services.dart';
import '../../../utils/app_constants.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController _controller = Get.put(MessageController());
  TextEditingController messageController = TextEditingController();
  final SocketServices _socket = SocketServices();

  final params = Get.parameters;
  var conversationId = "";
  var currentUserId = "";
  var currentUserName = "";
  var receiverImage = "";
  var receiverName = "";
  var receiverId = "";
  File? selectedIMage;

  @override
  void initState() {
    super.initState();
    _socket.init();
   // initNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserId();
      conversationId = Get.parameters['conversationId']!;
      currentUserId = params['currentUserId'] ?? "";
      receiverImage = params['receiverImage'] ?? "";
      receiverName = params['receiverName'] ?? "";
      receiverId = params['receiverId'] ?? "";
      _socket.emitMessagePage(receiverId);
      _controller.inboxFirstLoad(conversationId);
      _controller.listenMessage(conversationId);
    });
    //FirebaseMessaging.onMessage.listen(_onMessageReceived);
  }


/*

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        await _onSelectNotification(response.payload);
      },
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    if (payload == 'incoming_call') {
      Get.to(() => CallMethod(
        conversationID: conversationId,
        userID: receiverId,
        userName: receiverName,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ));
    }
  }

  Future<void> showIncomingCallNotification(String callerName) async {
    var androidDetails = const AndroidNotificationDetails(
      'call_channel_id',
      'Call Notifications',
      channelDescription: 'This channel is used for incoming call notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ongoing: true,
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Incoming Call',
      'You have an incoming call from $callerName',
      platformDetails,
      payload: 'incoming_call',
    );
  }*/

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  getUserId() async {
    currentUserId = await PrefsHelper.getString(AppConstants.userId);
    currentUserName = await PrefsHelper.getString(AppConstants.userName);
  }

  Future<void> _refreshMessages() async {
    getUserId();
    _controller.inboxFirstLoad(conversationId);
    _controller.listenMessage(conversationId);
  }

/*  void _onMessageReceived(RemoteMessage message) {
    if (message.data['type'] == 'call') {
      String callerName = message.data['callerName'] ?? 'Unknown';
      showIncomingCallNotification(callerName);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0.w,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl:
              "${ApiConstants.imageBaseUrl}${Get.parameters["receiverImage"]}",
              height: 45.h,
              width: 45.w,
              boxShape: BoxShape.circle,
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: CustomText(
                text: "${Get.parameters["receiverName"]}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                maxLine: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => CallMethod(
                  conversationID: conversationId,
                  userID: receiverId,
                  userName: receiverName,
                  config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
                ));
              },
              child: SvgPicture.asset(AppIcons.audio)),
          SizedBox(width: 16.w),
          InkWell(
              onTap: () {
                Get.to(() => CallMethod(
                  conversationID: conversationId,
                  userID: receiverId,
                  userName: receiverName,
                  config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
                ));
              },
              child: SvgPicture.asset(AppIcons.video)),
          SizedBox(width: 24.w),
        ],
      ),
      body: Obx(() {
        if (_controller.inboxFirstLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: _refreshMessages,
                        child: GroupedListView<MessageModel, DateTime>(
                          elements: _controller.messageModel.value,
                          controller: _controller.scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          order: GroupedListOrder.DESC,
                          itemComparator: (item1, item2) =>
                              item1.createdAt!.compareTo(item2.createdAt!),
                          groupBy: (MessageModel message) => DateTime(
                              message.createdAt!.year,
                              message.createdAt!.month,
                              message.createdAt!.day),
                          reverse: true,
                          shrinkWrap: true,
                          groupSeparatorBuilder: (DateTime date) {
                            return const SizedBox();
                          },
                          itemBuilder: (context, MessageModel message) {
                            return message.msgByUserId!.id == currentUserId
                                ? senderBubble(context, message)
                                : receiverBubble(context, message);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295.w,
                child: CustomTextField(
                  controller: messageController,
                  hintText: "Type something…",
                  suffixIcons: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: GestureDetector(
                        onTap: () {
                          openGallery();
                        },
                        child: SvgPicture.asset(AppIcons.attach,
                            color: AppColors.greyColor)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (messageController.text.isNotEmpty &&
                      !_controller.sentMessageLoading.value) {
                    _controller.sentMessage(
                        conversationId, 'text', messageController.text);
                    messageController.clear();
                  } else if (_controller.imagesPath.value.isNotEmpty) {
                    _controller.sentImage(conversationId, 'image');
                  } else {
                    Fluttertoast.showToast(msg: 'Please write a message');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      AppIcons.sendIcon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //===============================> Receiver Bubble <=============================
  receiverBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
            imageUrl: '${ApiConstants.imageBaseUrl}$receiverImage',
            boxShape: BoxShape.circle,
            height: 38.h,
            width: 38.w),
        SizedBox(width: 8.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: AppColors.cardColor,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                      imageUrl:
                      '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                      borderRadius: BorderRadius.circular(8.r),
                      height: 140.h,
                      width: 155.w)
                      : Text(
                    '${message.text}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //===============================> Sender Bubble <=============================
  senderBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                      imageUrl:
                      '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                      borderRadius: BorderRadius.circular(8.r),
                      height: 140.h,
                      width: 155.w)
                      : Text(
                    "${message.text}",
                    style:
                    TextStyle(color: Colors.white, fontSize: 16.sp),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> openGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _controller.imagesPath.value = pickedFile.path;
      _controller.update();
    }
  }
}

class CallMethod extends StatelessWidget {
  final String userID;
  final String userName;
  final String conversationID;
  final ZegoUIKitPrebuiltCallConfig config;

  const CallMethod({
    Key? key,
    required this.userID,
    required this.userName,
    required this.conversationID,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1059598849,
      appSign: '6ea42a0e9c416a604335cf5d521cc0120cf4244d4dac79a6c0419eba10150a99',
      userID: userID,
      userName: userName,
      callID: conversationID,
      config: config,
    );
  }
}

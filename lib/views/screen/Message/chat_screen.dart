import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../controllers/messages/message_controller.dart';
import '../../../helpers/time_formate.dart';
import '../../../models/message_model.dart';
import '../../base/custom_loading.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_page_loading.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController _controller = Get.put(MessageController());
  final StreamController _streamController = StreamController();
  var conversationId = "";
  var currentUserId = "";
  var currentUserImage = "";
  var receiverImage = "";
  var receiverName = "";
  var receiverId = "";

  Uint8List? _image;
  File? selectedIMage;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.scrollController
          .jumpTo(_controller.scrollController.position.maxScrollExtent);
      // _controller.createConversation(Get.arguments['conversationID']);
      conversationId = Get.parameters['conversationId'] ?? '';
      currentUserId = Get.parameters['currentUserId'] ?? '';
      currentUserImage = Get.parameters['currentUserImage'] ?? '';
      receiverImage = Get.parameters['receiverImage'] ?? '';
      receiverName = Get.parameters['receiverName'] ?? '';
      receiverId = Get.parameters['receiverId'] ?? '';
      if (conversationId.isNotEmpty) {
        _controller.listenMessage(conversationId);
        _controller.inboxFirstLoad(conversationId);
      } else {
        debugPrint("Error: conversationId is null or empty");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      //========================================> AppBar Section <=======================================
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                //=====================> Image <=======================
                CustomNetworkImage(
                  imageUrl: '${ApiConstants.imageBaseUrl}$receiverImage',
                  height: 45.h,
                  width: 45.w,
                  boxShape: BoxShape.circle,
                ),
                //=====================> Active Green Icon <=======================
                Positioned(
                  right: 0.w,
                  bottom: 4.h,
                  child: Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 10.w,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: receiverName,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'Active 30 minutes ago',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          //==============================> Audio Call Button <=======================
          InkWell(onTap: () {}, child: SvgPicture.asset(AppIcons.audio)),
          SizedBox(width: 16.w),
          //==============================> Video Call Button <=======================
          InkWell(onTap: () {}, child: SvgPicture.asset(AppIcons.video)),
          SizedBox(width: 24.w),
        ],
      ),
      //========================================> Body Section <=======================================
      body: Obx(() {
        if (_controller.inboxfirstLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        return SafeArea(
          child: Container(
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
                        StreamBuilder(
                          stream: _streamController.stream,
                          builder: (context, snapshot) {
                            if (true) {
                              return ListView.builder(
                                  controller: _controller.scrollController,
                                  dragStartBehavior: DragStartBehavior.down,
                                  itemCount:
                                      _controller.messageModel.length,
                                  itemBuilder: (context, index) {
                                    var message = _controller
                                        .messageModel[index];
                                    if (message.msgByUserId!.id ==
                                        currentUserId) {
                                      return senderBubble(context, message);
                                    } else if (message.msgByUserId!.id !=
                                        currentUserId) {
                                      return receiverBubble(context, message);
                                    } else {
                                      return SizedBox();
                                    }
                                    /*  return message['status'] == "sender"
                                        ? senderBubble(context, message)
                                        : receiverBubble(context, message);*/
                                  });
                            } else {
                              return const CustomLoading();
                            }
                          },
                        ),
                        //========================================> Show Select Image <============================
                        Positioned(
                            bottom: 0.h,
                            left: 0.w,
                            child: Column(
                              children: [
                                if (_image != null)
                                  Stack(
                                    children: [
                                      Container(
                                        height: 120.h,
                                        width: 120.w,
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(_image!),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          //border: Border.all(color: AppColors.primaryColor),
                                        ),
                                      ),
                                      //========================================> Cancel Icon <============================
                                      Positioned(
                                          top: 0.h,
                                          left: 0.w,
                                          child: GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Icon(
                                                  Icons.cancel_outlined)))
                                    ],
                                  ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  //===============================================> Write Sms Section <=============================
                  SizedBox(height: 80.h),
                ],
              ),
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
                  controller: _controller.sentMsgCtrl,
                  hintText: "Type something…",
                  suffixIcons: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: GestureDetector(
                        onTap: () {
                          _controller.pickImages(ImageSource.gallery);
                        },
                        child: SvgPicture.asset(AppIcons.attach,
                            color: AppColors.greyColor)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_controller.sentMsgCtrl.text.isNotEmpty) {
                    _controller.sentMessage(conversationId, 'text');
                  }
                  else if (  _controller.imagesPath.value.isNotEmpty){
                    _controller.sentImage(conversationId, 'image');
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Please Write message');
                  }
                  setState(() {});
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SvgPicture.asset(
                        AppIcons.sendIcon,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  //=============================================> Receiver Bubble <=================================
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
                  message.type == 'image'
                      ? CustomNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                          borderRadius: BorderRadius.circular(8),
                          height: 140.h,
                          width: 155.w)
                      : Text(
                          message.text ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
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

  //=============================================> Sender Bubble <========================================
  senderBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(
              type: BubbleType.sendBubble,
            ),
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
                  message.type == 'image'
                      ? CustomNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                          borderRadius: BorderRadius.circular(8),
                          height: 140.h,
                          width: 155.w)
                      : Text(
                          message.text ?? "",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        /*SizedBox(width: 8.w),
        CustomNetworkImage(
            imageUrl: message['image']!,
            boxShape: BoxShape.circle,
            height: 38.h,
            width: 38.w),*/
      ],
    );
  }
  //==================================> Gallery <===============================
  Future openGallery() async {
    final pickImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      // selectedIMage = File(pickImage!.path);
      // _image = File(pickImage.path).readAsBytesSync();
    });
  }
  //================================> Popup Menu Button Method <=============================
 /* PopupMenuButton<int> _popupMenuButton() {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      onSelected: (int result) {
        if (result == 0) {
          if (kDebugMode) {
            print('Report selected');
          }

          Get.toNamed(AppRoutes.reportScreen, parameters: {
            'receiverId': recevierId,
          });

        } else if (result == 1) {
          print('Block selected');
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              const Icon(Icons.report, color: Colors.black54),
              SizedBox(width: 10.w),
              const Text(
                'Report',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              const Icon(Icons.block, color: Colors.black54),
              SizedBox(width: 10.w),
              const Text(
                'Block',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }*/
}

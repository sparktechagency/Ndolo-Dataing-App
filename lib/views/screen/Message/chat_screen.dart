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
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../controllers/messages/message_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/time_formate.dart';
import '../../../models/message_model.dart';
import '../../../utils/app_constants.dart';
import '../../base/custom_loading.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController _controller = Get.put(MessageController());
  TextEditingController messageController = TextEditingController();
  var conversationId="";
  var currentUserId="";
  var currentUserImage="";
  var receiverImage="";
  var receiverName="";
  var receiverId="";
  File? selectedIMage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserId();
      conversationId=Get.parameters['conversationId']!;
      currentUserId=Get.parameters['currentUserId']!;
      receiverImage = Get.parameters['receiverImage']!;
      receiverName= Get.parameters['receiverName']!;
      receiverId = Get.parameters['receiverId']!;
      _controller.inboxFirstLoad(conversationId);
      _controller.listenMessage(conversationId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUserId() async {
    currentUserId = await PrefsHelper.getString(AppConstants.userId);
    print('currentId ======================> ${currentUserId}');
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
            CustomText(
              text: "${Get.parameters["receiverName"]}",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          //==============================> Audio Call Button <=======================
          InkWell(onTap: () {
            actionButton(
                context, false, Get.parameters['senderId']!,
                Get.parameters['senderName']!);
            }, child: SvgPicture.asset(AppIcons.audio)),
          SizedBox(width: 16.w),
          //==============================> Video Call Button <=======================
          InkWell(onTap: () {
            actionButton(
                context, true, Get.parameters['senderId']!,
                Get.parameters['senderName']!);
          }, child: SvgPicture.asset(AppIcons.video)),
          SizedBox(width: 24.w),
        ],
      ),
      //========================================> Body Section <=======================================
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
                      GroupedListView<MessageModel, DateTime>(
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
                          print('Current User ID: =========> $currentUserId');  // Debugging
                          print('Message Sent By: =========>${Get.parameters["receiverId"]}');  // Debugging
                          return message.msgByUserId!.id == currentUserId
                              ? senderBubble(context, message)
                              : receiverBubble(context, message);
                        },
                      ),
                      //========================================> Show Select Image <============================
                      Positioned(
                        bottom: 0.h,
                        left: 0.w,
                        child: Obx(() {
                          if (_controller.imagesPath.value.isNotEmpty) {
                            return Stack(
                              children: [
                                Container(
                                  height: 120.h,
                                  width: 120.w,
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                          File(_controller.imagesPath.value)),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                Positioned(
                                  top: 0.h,
                                  left: 0.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.imagesPath.value = "";
                                      _controller.update();
                                    },
                                    child: const Icon(Icons.cancel_outlined),
                                  ),
                                )
                              ],
                            );
                          }
                          return const SizedBox();
                        }),
                      ),
                    ],
                  ),
                ),
                //===============================================> Write Sms Section <=============================
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
                  if (messageController.text.isNotEmpty && !_controller.sentMessageLoading.value ) {
                    _controller.sentMessage(conversationId, 'text', messageController.text);
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
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                      imageUrl: '${ApiConstants.imageBaseUrl}${message.imageUrl}',
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
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                      imageUrl: '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                      borderRadius: BorderRadius.circular(8.r),
                      height: 140.h,
                      width: 155.w)
                      : Text(
                          "${message.text}",
                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
  Future<void> openGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _controller.imagesPath.value = pickedFile.path;
      _controller.update();
    }
  }

  //==================================> Zego Send Call Invitation Button <===============================
  ZegoSendCallInvitationButton actionButton(
      BuildContext context, bool isVideo, String userId, String name) {
    return ZegoSendCallInvitationButton(
      invitees: [
        ZegoUIKitUser(
          id: userId,
          name: name,
        )
      ],
      buttonSize: const Size(30, 30),
      iconSize: const Size(30, 30),
      resourceID: 'zegouikit_call',
      isVideoCall: isVideo,
    );
  }
}
